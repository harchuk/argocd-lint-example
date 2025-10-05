.PHONY: lint lint-render lint-security lint-dry-run

lint:
	scripts/lint.sh

lint-render:
	scripts/lint_with_render.sh

lint-security:
	scripts/lint_security.sh --severity-threshold=warn

lint-dry-run:
	scripts/lint_with_dry_run.sh --severity-threshold=error
