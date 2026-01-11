#!/usr/bin/env bash
# Install Argo CD (pinned version) and print the initial admin password command.
set -euo pipefail

ARGOCD_VERSION="${ARGOCD_VERSION:-v2.12.4}"

command -v kubectl >/dev/null || { echo "kubectl required" >&2; exit 1; }

kubectl get ns argocd >/dev/null 2>&1 || kubectl create namespace argocd
kubectl apply -n argocd -f "https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/install.yaml"
kubectl -n argocd rollout status deploy/argocd-server --timeout=300s

echo "Admin password:"
echo "  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
