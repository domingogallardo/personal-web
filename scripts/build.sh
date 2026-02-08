#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v hugo >/dev/null 2>&1; then
  echo "❌ Hugo no está instalado. Instálalo con: brew install hugo"
  exit 1
fi

hugo \
  --source "$ROOT_DIR" \
  --destination "$ROOT_DIR/public" \
  --cleanDestinationDir
