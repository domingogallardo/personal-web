#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "⚠️ scripts/deploy-docflow.sh ahora es un alias."
echo "   Ejecutando scripts/deploy-remote.sh..."
exec "$ROOT_DIR/scripts/deploy-remote.sh" "$@"
