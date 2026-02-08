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

## Integración con docflow (despliegue)
El despliegue se hace reutilizando el script de docflow (`web/deploy.sh`).
Este script combina el sitio generado aquí con el índice `/read` creado por docflow.

1. Asegúrate de tener el repo de docflow disponible (por defecto `../Python/docflow`).
2. Crea y configura `../Python/docflow/.env.deploy` con al menos:
   - `REMOTE_USER`
   - `REMOTE_HOST`
   - `HTPASSWD_USER`
   - `HTPASSWD_PSS`
3. Carga variables y ejecuta el despliegue:
   `set -a; source ../Python/docflow/.env.deploy; set +a; scripts/deploy-docflow.sh`

Opcionalmente puedes fijar la ruta de docflow:
`DOCFLOW_DIR=/ruta/a/docflow REMOTE_USER=... REMOTE_HOST=... scripts/deploy-docflow.sh`

También puedes pasar variables inline si no usas `.env.deploy`:
`REMOTE_USER=root REMOTE_HOST=TU_SERVIDOR scripts/deploy-docflow.sh`

## Notas
- `public/` es generado por Hugo y no se versiona.
- `public_legacy/` contiene la versión estática anterior como referencia.
