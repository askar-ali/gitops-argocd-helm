# Design notes

- **App-of-apps**: `root` watches `apps/`; adding a file there deploys a workload.
- **Environments**: same chart, different `values-<env>.yaml`.
- **Safety**: dev auto-prunes; prod has `selfHeal` but `prune: false` so deletions are deliberate.
- **Pod security**: chart defaults to non-root, read-only rootfs, dropped capabilities,
  seccomp RuntimeDefault, no service account token mount.
- **Promotion**: CI bumps `image.tag` in `values-dev.yaml`; a PR promotes it to prod.
- **Not covered**: image automation, SOPS/Vault secrets (see project 3 for hardening).

## Validation
`helm lint charts/webapp` and `helm template charts/webapp -f charts/webapp/values-prod.yaml | kubeconform -strict`.
