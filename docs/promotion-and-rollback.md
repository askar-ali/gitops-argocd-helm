# Promotion and rollback

## Promote
1. CI builds an image and runs `scripts/bump-image-tag.sh dev <tag>`, committing to `main`.
2. Argo CD syncs dev automatically; verify.
3. Open a PR running `bump-image-tag.sh prod <tag>`; merge after review.
4. Prod syncs with `selfHeal` but without pruning; deletions are an explicit step.

## Roll back
`git revert <commit>` and push. Argo CD reconciles to the previous state.
Avoid `argocd app rollback` on auto-synced apps: self-heal reverts it.

## Drift
Manual `kubectl edit` changes are reverted by `selfHeal`. Change Git instead.
