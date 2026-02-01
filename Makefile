.PHONY: validate bump-dev
validate:
	scripts/validate.sh

bump-dev:
	scripts/bump-image-tag.sh dev $(TAG)
