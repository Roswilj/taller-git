#!/usr/bin/env bash

# Detiene el script si encuentra un error no controlado.
set -euo pipefail

# Se coloca en la raíz del proyecto.
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

# Comprueba el recetario. Si falla, no continúa.
bash scripts/validar-recetario.sh

# Define dónde se preparará la entrega.
salida="dist/recetario"

# Crea dist si todavía no existe.
mkdir -p dist

# Elimina únicamente la entrega generada anteriormente.
rm -rf -- "$salida"

# Crea una carpeta vacía para la nueva entrega.
mkdir -p "$salida"

# Copia los archivos principales.
cp README.md VERSION CHANGELOG.md "$salida/"

# Copia la carpeta recetas con todo su contenido.
cp -R recetas "$salida/"

# Muestra dónde quedó preparada la entrega.
printf 'PAQUETE PREPARADO: %s\n' "$salida"