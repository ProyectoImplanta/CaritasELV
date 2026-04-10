#!/bin/bash

branch="$(git rev-parse --abbrev-ref HEAD)"

# 1. Bloqueo de Commits directos
if [ "$branch" = "main" ] || [ "$branch" = "develop" ]; then
  # Revisar si es un merge
  if [ -f .git/MERGE_HEAD ]; then
    echo "--------------------------------------------------------"
    echo "❌ BLOQUEO DE MERGE: No puedes mergear nada aquí localmente."
    echo "Haz el Merge a través de un Pull Request en GitHub web."
    echo "--------------------------------------------------------"
    # Cancelar el merge
    git merge --abort
    exit 1
  fi

  echo "--------------------------------------------------------"
  echo "❌ BLOQUEO DE COMMIT: No puedes crear commits en $branch."
  echo "--------------------------------------------------------"
  exit 1
fi
