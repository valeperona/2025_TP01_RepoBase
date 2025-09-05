#!/usr/bin/env bash
# Cuenta líneas de un archivo de texto.
# Uso: ./scripts/linecount.sh archivo.txt

set -euo pipefail
file="${1:-}"
if [[ -z "$file" || ! -f "$file" ]]; then
  echo "Uso: $0 <archivo.txt>" >&2
  exit 1
fi
wc -l "$file"
