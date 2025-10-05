# Расширенные сценарии argocd-lint

Этот документ дополняет `README.md` и показывает, как комбинировать разные возможности `argocd-lint`.

## Сценарий 1. Мульти-репозиторий и multi-source приложения

- Используйте `manifests/advanced/app-multi-source.yaml`, чтобы увидеть, как линтер проверяет `spec.sources` с несколькими репозиториями.
- Запустите:
  ```bash
  argocd-lint manifests/advanced/app-multi-source.yaml --rules argocd-lint-config/baseline.yaml --format table
  ```
- Обратите внимание на правила `AR009` и `AR011`, которые гарантируют целостность описаний.

## Сценарий 2. Рендеринг Helm/Kustomize + dry-run

- Локальные исходники для рендера лежат в `render-sources/`.
- Команда ниже запустит рендер, а затем проверит ресурсы через kubeconform:
  ```bash
  HELM_BINARY=$(command -v helm)
  KUSTOMIZE_BINARY=$(command -v kustomize)
  DRY_RUN_MODE=kubeconform scripts/lint_with_dry_run.sh --rules argocd-lint-config/prod-strict.yaml
  ```
- Можно переключиться на серверный dry-run, указав `DRY_RUN_MODE=server` и `KUBECONFIG`.

## Сценарий 3. Пользовательские политики безопасности

- Директория `policy-plugins/custom/` содержит Rego-правила.
- Для их применения используйте:
  ```bash
  scripts/lint_security.sh --severity-threshold=warn --format json
  ```
- В отчётах появятся пользовательские идентификаторы нарушений (`TEAM_LABEL_REQUIRED`, `DRY_RUN_RECOMMENDED`).

## Сценарий 4. Разделение rulebook по командам

- `argocd-lint-config/team-payments.yaml` и `argocd-lint-config/local-development.yaml` демонстрируют, как варьировать требования на разных путях.
- В CI можно запускать матричный пайплайн, применяя каждую конфигурацию отдельно (см. `.github/workflows/lint.yaml`).

## Сценарий 5. Repo-server CMP

- Используйте `argocd-lint-config/repo-server.yaml` как основу для Config Management Plugin.
- Файл `pipelines/argo-workflows.yaml` показывает, как встроить линтер в Argo Workflows, который часто используется для кастомных pre-sync проверок.

## Советы по расширению

1. Добавьте собственные Rego-файлы в `policy-plugins/custom/` и обновите `argocd-lint-config/security.yaml`.
2. Создайте дополнительные overrides, например, `pattern: "manifests/*/beta/**"`, чтобы смягчить правила в экспериментальных ветках.
3. Интегрируйте SARIF-отчёты с GitHub Code Scanning или загрузите JSON в любую систему, поддерживающую кастомные отчёты качества.
