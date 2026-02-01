#!/usr/bin/env bash
# Lint and schema-validate the chart for every environment.
set -euo pipefail
cd "$(dirname "$0")/.."

for bin in helm kubeconform; do
  command -v "$bin" >/dev/null || { echo "missing: $bin" >&2; exit 1; }
done

for env in dev prod; do
  echo "== $env =="
  helm lint charts/webapp -f "charts/webapp/values-${env}.yaml"
  helm template "webapp-${env}" charts/webapp -f "charts/webapp/values-${env}.yaml" \
    | kubeconform -strict -ignore-missing-schemas -summary
done
