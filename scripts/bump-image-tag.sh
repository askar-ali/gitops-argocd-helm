#!/usr/bin/env bash
# CI helper: set image.tag in an environment values file. Usage: bump-image-tag.sh <env> <tag>
set -euo pipefail

ENVIRONMENT="${1:?env}"
TAG="${2:?tag}"
FILE="$(dirname "$0")/../charts/webapp/values-${ENVIRONMENT}.yaml"

if grep -q '^image:' "$FILE"; then
  sed -i -E "/^image:/,/^[^ ]/ s/^(  tag:).*/\1 \"${TAG}\"/" "$FILE"
else
  printf '\nimage:\n  tag: "%s"\n' "$TAG" >> "$FILE"
fi
echo "Set ${ENVIRONMENT} image.tag=${TAG}"
