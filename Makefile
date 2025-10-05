.PHONY: lint lint-render lint-security lint-dry-run plan-appset plugins-list

lint:
	scripts/lint.sh

lint-render:
	scripts/lint_with_render.sh

lint-security:
	scripts/lint_security.sh --severity-threshold=warn

lint-dry-run:
	scripts/lint_with_dry_run.sh --severity-threshold=error

plan-appset:
	scripts/appset_plan.sh

plugins-list:
	scripts/list_plugins.sh
