# Custom argocd-lint plugins

Эта директория иллюстрирует, как подключить собственные Rego-правила к `argocd-lint` и как описывать метаданные в формате 0.2.0.

- `require_team_label.rego` — проверяет, что каждая `Application` и `ApplicationSet` содержит метку `team` или `app.kubernetes.io/managed-by`.
- `require_dry_run_annotation.rego` — рекомендует фиксировать стратегию dry-run для production ресурсов.

Оба файла объявляют секцию `metadata`, поэтому команда

```bash
argocd-lint plugins list --dir policy-plugins/custom
```

вернёт структурированную сводку правил (id, category, severity, help_url).

Подключите каталог через `--plugin-dir policy-plugins/custom` или добавьте его в конфигурацию `plugins:`.
