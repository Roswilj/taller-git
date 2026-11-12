#!/bin/bash
# Cuenta las recetas del recetario y comprueba que cada una esté en la lista del README.
set -e
total=$(ls recetas/*.md | wc -l)
echo "Recetas en la carpeta: $total"
for archivo in recetas/*.md; do
  if ! grep -q "($archivo)" README.md; then
    echo "FALTA en el README: $archivo"
  fi
done
