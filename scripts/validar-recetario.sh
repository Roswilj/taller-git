#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

fallar() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

for archivo in README.md VERSION CHANGELOG.md; do
  [[ -s "$archivo" ]] || fallar "Falta $archivo o esta vacio."
done
[[ -d recetas ]] || fallar "Falta la carpeta recetas."

version=$(tr -d '\r' < VERSION)
patron_version='^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$'
[[ "$version" =~ $patron_version ]] ||
  fallar "VERSION debe contener solo un numero como 1.1.1."
printf 'OK: VERSION=%s.\n' "$version"

referencias=0
patron_receta='^- .*\((recetas/[^()]+\.md)\)$'
while IFS= read -r linea || [[ -n "$linea" ]]; do
  linea=${linea%$'\r'}
  if [[ "$linea" == '- '* && "$linea" == *'recetas/'* ]]; then
    [[ "$linea" =~ $patron_receta ]] ||
      fallar "Referencia mal escrita en README.md: $linea"
    ruta=${BASH_REMATCH[1]}
    [[ "$ruta" != *'/../'* && "$ruta" != *'/./'* ]] ||
      fallar "Ruta no permitida en README.md: $ruta"
    [[ -f "$ruta" ]] ||
      fallar "README.md apunta a $ruta, pero ese archivo no existe."
    referencias=$((referencias + 1))
  fi
done < README.md
[[ "$referencias" -gt 0 ]] ||
  fallar "README.md no tiene referencias a recetas."
printf 'OK: %s referencias apuntan a recetas existentes.\n' "$referencias"

shopt -s nullglob
archivos=(README.md VERSION CHANGELOG.md recetas/*.md)
for archivo in "${archivos[@]}"; do
  if grep -nE '^(<<<<<<< |=======[[:space:]]*$|>>>>>>> )' "$archivo"; then
    fallar "Hay marcadores de conflicto en $archivo."
  fi
done
printf 'OK: no hay marcadores de conflicto.\n'
printf 'VALIDACION CORRECTA.\n'