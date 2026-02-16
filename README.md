# Web personal (Hugo)

Este repositorio contiene la web personal en Hugo. El contenido vive en `content/` y los listados de publicaciones/software se cargan desde `data/`.
Hugo genera el sitio estático en `public/`.

## Estructura
- `content/posts/`: entradas del blog en Markdown.
- `content/publications/`: índice de publicaciones (usa `data/publications.yaml`).
- `content/software/`: índice de proyectos (usa `data/software.yaml`).
- `content/contact/`: página de contacto.
- `data/publications.yaml`: lista de publicaciones (formato minimal).
- `data/software.yaml`: lista de software.
- `static/`: archivos estáticos (imágenes, soporte de apps, PDFs, etc.).
- `layouts/`: plantillas Hugo.
- `scripts/`: comandos de build y despliegue.

## Desarrollo local
1. Instala Hugo si no lo tienes:
   `brew install hugo`
2. Arranca el servidor:
   `hugo server -D`

## Build
- Generar estático:
  `scripts/build.sh`

## Despliegue remoto (DigitalOcean)
El repo incluye todo lo necesario para desplegar sin depender de `docflow`.

1. Crea tu entorno local de despliegue:
   `cp .env.deploy.example .env.deploy`
2. Edita `.env.deploy` y define al menos:
   - `REMOTE_USER`
   - `REMOTE_HOST`
3. Carga variables y ejecuta:
   `set -a; source .env.deploy; set +a; scripts/deploy-remote.sh`

Notas:
- `scripts/deploy-remote.sh` genera `public/` con Hugo, empaqueta `deploy/Dockerfile` + `deploy/nginx.conf` + estáticos y despliega por `ssh/scp`.
- El script crea/actualiza en remoto `/opt/web-domingo` por defecto (se puede cambiar con `REMOTE_PATH`).
- Si defines `HTPASSWD_USER` y `HTPASSWD_PSS`, el script actualiza `/opt/web-domingo/nginx/.htpasswd`.
- `scripts/deploy-docflow.sh` se mantiene como alias para compatibilidad y llama al mismo deploy.
- Si quieres inyectar un `/read` externo durante el deploy, usa `READ_SOURCE_DIR=/ruta/al/read`.

## Notas
- `public/` es generado por Hugo y no se versiona.
- `public_legacy/` contiene la versión estática anterior como referencia.
