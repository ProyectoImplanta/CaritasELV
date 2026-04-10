#!/bin/bash

# Obtener el nombre de la rama actual
branch="$(git rev-parse --abbrev-ref HEAD)"

# Definir las ramas donde está prohibido hacer commit
if [ "$branch" = "main" ] || [ "$branch" = "develop" ]; then
  echo "----------------------------------------------------------"
  echo "❌ ERROR: No puedes hacer commit directamente en '$branch'."
  echo "Debes trabajar en una rama de tarea y subir a 'integration'."
  echo "----------------------------------------------------------"
  exit 1
fi
