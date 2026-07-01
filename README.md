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

## Resúmenes de tweets

Los posts tipo `resumen-tweets-*` se generan a partir de las notas Markdown que crea [`docflow`](https://github.com/domingogallardo/docflow) en:

`/Users/domingo/⭐️ Documentación/Tweets/Tweets YYYY/`

El script principal es:

`python3 scripts/list-tweet-summary-candidates.py YYYY-MM`

### Qué incluye el script
- Lee las notas individuales de tweets de `docflow`.
- Incluye solo tweets cuyo front matter cumpla:
  - `source: tweet`
  - `tweet_author: "@domingogallardo"`
  - `tweet_posted_kind != repost`
- Calcula la fecha real con `tweet_id`, a partir del snowflake de X/Twitter.
- Evita duplicados cuando `docflow` contiene más de una nota para el mismo `tweet_id`.
- Extrae el texto propio del tweet y corta antes de bloques externos de `docflow`: tweets citados, tweets favoritos, contexto de respuesta, imágenes y metadatos.
- En replies, cuando existe `#### Mi respuesta`, usa solo tu respuesta.
- Agrupa por día y añade el shortcode de embed:
  `{{< tweet url="https://x.com/domingogallardo/status/..." >}}`
- Entre varios tweets del mismo día añade:
  `<p>❄ ❄ ❄ ❄ ❄</p>`

El post no tiene por qué ser exhaustivo. Después de generar la base se pueden descartar tweets demasiado contextuales, repetidos, con poco texto o que no aporten bien fuera de X.

### Comandos habituales

Generar todo un mes:

`python3 scripts/list-tweet-summary-candidates.py 2026-05 > /tmp/tweets-mayo-2026.md`

Generar la primera quincena:

`python3 scripts/list-tweet-summary-candidates.py 2026-06 --start-day 1 --end-day 15 > /tmp/tweets-junio-2026-q1.md`

Generar la segunda quincena:

`python3 scripts/list-tweet-summary-candidates.py 2026-06 --start-day 16 > /tmp/tweets-junio-2026-q2.md`

Cambiar la carpeta fuente, si hace falta:

`python3 scripts/list-tweet-summary-candidates.py 2026-06 --tweets-root "/ruta/a/Tweets" > /tmp/tweets-junio-2026.md`

### Crear un post nuevo

1. Genera la salida base en `/tmp`.
2. Revisa el archivo y elimina manualmente tweets poco útiles, demasiado contextuales o repetidos.
3. Crea el bundle Hugo:
   `content/posts/resumen-tweets-mes-YYYY/index.md`
4. Añade este front matter, ajustando título y fecha:
   ```yaml
   ---
   title: "Mis tweets de mayo de 2026"
   date: 2026-05-31
   draft: false
   tags:
     - "tweets"
   ---
   ```
5. Pega debajo los tweets seleccionados, tal como salen del script.
6. Si hay versión inglesa, crea `index.en.md` con el mismo slug y fecha, `title` en inglés y el contenido traducido.
7. Comprueba que compila:
   `scripts/build.sh`

### Checks rápidos

Comprobar que el rango de fechas es el esperado:

```bash
rg -n '^## ' /tmp/tweets-junio-2026-q1.md
```

Contar embeds:

```bash
rg -c '\{\{< tweet' /tmp/tweets-junio-2026-q1.md
```

Compilar el sitio:

```bash
scripts/build.sh
```

### Notas de mantenimiento
- La selección de autor y tipo se hace con campos del front matter; no hace falta buscar el autor en el cuerpo del Markdown.
- Si cambia el formato de las notas de `docflow` y se cuela texto externo, revisar `is_tweet_boundary()` en `scripts/list-tweet-summary-candidates.py`.
- El shortcode `tweet` activa `platform.twitter.com/widgets.js` solo en las páginas que lo usan.
- El RSS de posts elimina los embeds de Twitter para que el feed no arrastre el bloque HTML externo.
