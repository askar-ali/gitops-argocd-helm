# gitops-argocd-helm

GitOps delivery with **Argo CD** and **Helm**: cluster state is declared in Git
and reconciled automatically. Uses the app-of-apps pattern with dev and prod
environments.

> Lab recreation of GitOps patterns I use in production (since 10/2025).
> Generic sample app, placeholder repo URL.

## Why GitOps

- Git is the single source of truth; every change is a reviewed commit.
- Argo CD continuously reconciles and self-heals drift.
- Rollback = `git revert`.
- No cluster credentials in CI: CI only builds images and bumps a tag in Git.

## Layout

```
bootstrap/       install script + root Application (app-of-apps)
apps/dev|prod/   one Argo CD Application per workload per environment
charts/webapp/   Helm chart (values-dev / values-prod overrides)
docs/            design notes
```

## Flow

```
git push -> root app (bootstrap/root-app.yaml) -> apps/<env>/*.yaml -> charts/webapp -> cluster
```

## Quickstart

```bash
./bootstrap/install-argocd.sh          # installs Argo CD into the cluster
# edit REPO_URL in apps/ and bootstrap/root-app.yaml, push, then:
kubectl apply -f bootstrap/root-app.yaml
```
