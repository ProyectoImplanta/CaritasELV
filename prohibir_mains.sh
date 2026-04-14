#!/bin/bash

branch="$(git rev-parse --abbrev-ref HEAD)"

if [ "$branch" = "main" ] || [ "$branch" = "develop" ]; then
  
  # Detectar si hay un merge en curso o si se está intentando crear un commit de merge
  if [ -f .git/MERGE_HEAD ] || [ -d .git/rebase-apply ] || [ -d .git/rebase-merge ]; then
    echo "--------------------------------------------------------"
    echo "❌ ERROR: MERGE LOCAL DETECTADO EN $branch"
    echo "No puedes mezclar ramas localmente en esta rama."
    echo "Por favor, usa un Pull Request en GitHub."
    echo "--------------------------------------------------------"
    
    # Abortamos el proceso de merge inmediatamente
    git merge --abort >/dev/null 2>&1
    exit 1
  fi

  # Bloqueo de commit normal
  echo "--------------------------------------------------------"
  echo "❌ ERROR: COMMITS PROHIBIDOS EN $branch"
  echo "--------------------------------------------------------"
  exit 1
fi
