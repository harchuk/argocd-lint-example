# Custom argocd-lint plugins

Эта директория иллюстрирует, как подключить собственные Rego-правила к `argocd-lint`.

- `require_team_label.rego` — проверяет, что каждая `Application` и `ApplicationSet` содержит метку `team` или `app.kubernetes.io/managed-by`.
- `require_dry_run_annotation.rego` — рекомендует включить dry-run в пайплайнах для production окружений.

Подключите каталог через `--plugin-dir policy-plugins/custom` или укажите в конфигурации `plugins:`.
