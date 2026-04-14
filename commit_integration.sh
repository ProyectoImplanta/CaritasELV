#!/bin/bash

# 1. Verificar si hay cambios en el staging (git add .)
STAGED=$(git diff --cached --name-only)

if [ -z "$STAGED" ]; then
    echo "❌ Error: No hay archivos en el área de preparación (staging)."
    echo "💡 Ejecuta 'git add .' antes de usar este script."
    exit 1
fi

# 2. Generar el resumen (Summary) basado en los tipos de archivos y cantidad
COUNT=$(echo "$STAGED" | wc -l)
DATE=$(date +"%Y-%m-%d %H:%M")

# Detectar el tipo de cambio principal (simplificado)
if echo "$STAGED" | grep -q "src/slices/"; then
    TYPE="feat(slices)"
elif echo "$STAGED" | grep -q "prisma/schema.prisma"; then
    TYPE="db(schema)"
elif echo "$STAGED" | grep -q "package.json"; then
    TYPE="chore(deps)"
else
    TYPE="chore"
fi

SUMMARY="$TYPE: integración de cambios ($COUNT archivos) - $DATE"

# 3. Generar la descripción detallada con la lista de archivos reales
DESCRIPTION="🚀 Archivos integrados en esta sesión:\n\n$STAGED\n\n✅ Verificado por script de integración."

# 4. Ejecutar el commit
echo "📝 Creando commit con:"
echo "--------------------------------------"
echo -e "Título: $SUMMARY"
echo -e "Descripción:\n$DESCRIPTION"
echo "--------------------------------------"

git commit -m "$SUMMARY" -m "$(echo -e "$DESCRIPTION")"

# 5. Push automático a la rama actual
BRANCH=$(git branch --show-current)
echo "🚀 Subiendo cambios a origin $BRANCH..."
git push origin "$BRANCH"

echo "✅ Commit y Push completados exitosamente."
