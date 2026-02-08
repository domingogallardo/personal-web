#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCFLOW_DIR="${DOCFLOW_DIR:-$ROOT_DIR/../Python/docflow}"
DOCFLOW_DEPLOY="$DOCFLOW_DIR/web/deploy.sh"

if ! command -v hugo >/dev/null 2>&1; then
  echo "❌ Hugo no está instalado. Instálalo con: brew install hugo"
  exit 1
fi

if [[ ! -f "$DOCFLOW_DEPLOY" ]]; then
  echo "❌ No se encontró docflow en: $DOCFLOW_DEPLOY"
  echo "   Ajusta DOCFLOW_DIR o revisa la ruta del repo docflow."
  exit 1
fi

if [[ -z "${REMOTE_USER:-}" || -z "${REMOTE_HOST:-}" ]]; then
  echo "❌ Faltan variables REMOTE_USER y/o REMOTE_HOST."
  echo "   Ejemplo: REMOTE_USER=root REMOTE_HOST=1.2.3.4 $0"
  exit 1
fi

hugo \
  --source "$ROOT_DIR" \
  --destination "$ROOT_DIR/public" \
  --cleanDestinationDir

PERSONAL_WEB_DIR="$ROOT_DIR" REMOTE_USER="$REMOTE_USER" REMOTE_HOST="$REMOTE_HOST" \
  bash "$DOCFLOW_DEPLOY"
