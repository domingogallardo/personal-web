#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEPLOY_DIR="$ROOT_DIR/deploy"
BUILD_SCRIPT="$ROOT_DIR/scripts/build.sh"

REMOTE_PATH="${REMOTE_PATH:-/opt/web-domingo}"
IMAGE_NAME="${IMAGE_NAME:-web-domingo}"
CONTAINER_NAME="${CONTAINER_NAME:-web-domingo}"
HOST_PORT="${HOST_PORT:-8080}"
READ_SOURCE_DIR="${READ_SOURCE_DIR:-}"

require_cmd() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "❌ Falta comando requerido: $cmd"
    exit 1
  fi
}

if [[ -z "${REMOTE_USER:-}" || -z "${REMOTE_HOST:-}" ]]; then
  echo "❌ Faltan variables REMOTE_USER y/o REMOTE_HOST."
  echo "   Ejemplo: REMOTE_USER=root REMOTE_HOST=1.2.3.4 $0"
  exit 1
fi

require_cmd ssh
require_cmd scp
require_cmd tar

if [[ ! -x "$BUILD_SCRIPT" ]]; then
  echo "❌ No existe script de build: $BUILD_SCRIPT"
  exit 1
fi

if [[ ! -f "$DEPLOY_DIR/Dockerfile" || ! -f "$DEPLOY_DIR/nginx.conf" ]]; then
  echo "❌ Faltan archivos de despliegue en $DEPLOY_DIR (Dockerfile/nginx.conf)."
  exit 1
fi

cleanup() {
  if [[ -n "${STAGING_DIR:-}" && -d "$STAGING_DIR" ]]; then
    rm -rf "$STAGING_DIR"
  fi
  if [[ -n "${ARCHIVE_PATH:-}" ]]; then
    rm -f "$ARCHIVE_PATH"
  fi
}
trap cleanup EXIT

copy_tree() {
  local src="$1"
  local dest="$2"

  if command -v rsync >/dev/null 2>&1; then
    rsync -a --delete "$src"/ "$dest"/
  else
    rm -rf "$dest"
    mkdir -p "$dest"
    cp -R "$src"/. "$dest"/
  fi
}

echo "🏗️ Generando sitio con Hugo..."
"$BUILD_SCRIPT"

if [[ ! -d "$ROOT_DIR/public" ]]; then
  echo "❌ No existe $ROOT_DIR/public tras el build."
  exit 1
fi

STAGING_DIR="$(mktemp -d)"
PUBLIC_STAGING="$STAGING_DIR/public"
mkdir -p "$PUBLIC_STAGING"

echo "📁 Preparando contenido estático..."
copy_tree "$ROOT_DIR/public" "$PUBLIC_STAGING"

if [[ -n "$READ_SOURCE_DIR" ]]; then
  if [[ ! -d "$READ_SOURCE_DIR" ]]; then
    echo "❌ READ_SOURCE_DIR no existe o no es un directorio: $READ_SOURCE_DIR"
    exit 1
  fi
  echo "📚 Sobrescribiendo /read desde $READ_SOURCE_DIR..."
  rm -rf "$PUBLIC_STAGING/read"
  mkdir -p "$PUBLIC_STAGING/read"
  copy_tree "$READ_SOURCE_DIR" "$PUBLIC_STAGING/read"
fi

cp "$DEPLOY_DIR/Dockerfile" "$STAGING_DIR/Dockerfile"
cp "$DEPLOY_DIR/nginx.conf" "$STAGING_DIR/nginx.conf"

ARCHIVE_PATH="$DEPLOY_DIR/deploy.tar.gz"
rm -f "$ARCHIVE_PATH"

echo "📦 Empaquetando despliegue..."
CREATE_FLAGS=()
if tar --version 2>/dev/null | grep -qi bsdtar; then
  CREATE_FLAGS+=(--no-xattrs --no-mac-metadata)
fi

COPYFILE_DISABLE=1 tar "${CREATE_FLAGS[@]}" \
  --exclude='.DS_Store' \
  --exclude='._*' \
  -C "$STAGING_DIR" \
  -czf "$ARCHIVE_PATH" \
  Dockerfile \
  nginx.conf \
  public

echo "🛰️ Preparando servidor remoto..."
ssh "$REMOTE_USER@$REMOTE_HOST" "mkdir -p '$REMOTE_PATH' '$REMOTE_PATH/dynamic-data' '$REMOTE_PATH/nginx'"

if [[ -n "${HTPASSWD_USER:-}" && -n "${HTPASSWD_PSS:-}" ]]; then
  echo "🔐 Actualizando credenciales BasicAuth en el host remoto..."
  PASS_B64="$(printf '%s' "$HTPASSWD_PSS" | base64)"
  ssh "$REMOTE_USER@$REMOTE_HOST" HTPASSWD_USER="$HTPASSWD_USER" PASS_B64="$PASS_B64" REMOTE_PATH="$REMOTE_PATH" bash -s << 'EOSSH'
set -euo pipefail
if ! command -v htpasswd >/dev/null 2>&1; then
  apt-get update -y >/dev/null && apt-get install -y apache2-utils >/dev/null
fi
umask 027
printf '%s' "$PASS_B64" | base64 -d | htpasswd -iB -c "$REMOTE_PATH/nginx/.htpasswd" "$HTPASSWD_USER"
chown root:root "$REMOTE_PATH/nginx/.htpasswd"
chmod 644 "$REMOTE_PATH/nginx/.htpasswd"
EOSSH
  unset PASS_B64
elif [[ -n "${HTPASSWD_USER:-}" || -n "${HTPASSWD_PSS:-}" ]]; then
  echo "⚠️ HTPASSWD_USER/HTPASSWD_PSS incompletas. Se omite actualización de .htpasswd."
fi

echo "🚀 Subiendo artefacto..."
scp "$ARCHIVE_PATH" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH/deploy.tar.gz"

echo "🔧 Desplegando contenedor en remoto..."
ssh "$REMOTE_USER@$REMOTE_HOST" \
  REMOTE_PATH="$REMOTE_PATH" \
  IMAGE_NAME="$IMAGE_NAME" \
  CONTAINER_NAME="$CONTAINER_NAME" \
  HOST_PORT="$HOST_PORT" \
  bash -s << 'EOSSH'
set -euo pipefail

cd "$REMOTE_PATH"
rm -rf public

if tar --help 2>&1 | grep -q -- '--warning'; then
  tar --warning=no-unknown-keyword --warning=no-timestamp -xzf deploy.tar.gz
else
  tar -xzf deploy.tar.gz
fi
rm -f deploy.tar.gz

chown -R 100:101 "$REMOTE_PATH/dynamic-data" || true
chmod -R 755 "$REMOTE_PATH/dynamic-data" || true

OLD_IMAGE_ID="$(docker image inspect "$IMAGE_NAME" --format '{{.Id}}' 2>/dev/null || true)"

docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
docker build -t "$IMAGE_NAME" .

NEW_IMAGE_ID="$(docker image inspect "$IMAGE_NAME" --format '{{.Id}}' 2>/dev/null || true)"

if [[ -n "$OLD_IMAGE_ID" && "$OLD_IMAGE_ID" != "$NEW_IMAGE_ID" ]]; then
  docker image rm -f "$OLD_IMAGE_ID" >/dev/null 2>&1 || true
fi

RUN_ARGS=(
  -d
  -p "${HOST_PORT}:80"
  -v "$REMOTE_PATH/dynamic-data:/data:rw"
  --name "$CONTAINER_NAME"
)

if [[ -f "$REMOTE_PATH/nginx/.htpasswd" ]]; then
  RUN_ARGS+=(-v "$REMOTE_PATH/nginx/.htpasswd:/etc/nginx/.htpasswd:ro")
else
  echo "⚠️ No existe $REMOTE_PATH/nginx/.htpasswd; /data PUT quedará sin auth."
fi

docker run "${RUN_ARGS[@]}" "$IMAGE_NAME"

# Keep disk usage stable on the remote host after each deploy.
docker image prune -f >/dev/null 2>&1 || true
docker builder prune -af >/dev/null 2>&1 || true
EOSSH

echo "✅ Despliegue completado."
echo "🌐 Contenedor sirviendo en http://localhost:$HOST_PORT (en el host remoto)."
