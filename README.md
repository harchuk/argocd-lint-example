# argocd-lint example playground

Этот репозиторий демонстрирует, зачем нужен [`argocd-lint`](https://github.com/harchuk/argocd-lint) и как использовать его максимально широко: от локальной отладки Helm/Kustomize до гибких rulebook-ов и многоступенчатых CI/CD пайплайнов.

## Карта репозитория

- `manifests/` — десятки примеров `Application` и `ApplicationSet`:
  - `good/` и `bad/` показывают базовые best practices и типовые ошибки.
  - `environments/{dev,prod}/` отражают разделение по окружениям и работу overrides.
  - `advanced/` демонстрирует multi-source приложения, плагины и сценарии рендера.
  - `applicationsets/` включает list/matrix генераторы с валидными и проблемными шаблонами.
- `render-sources/` — Helm chart и Kustomize оverlay-и, которые можно реально отрендерить через `--render`.
- `argocd-lint-config/` — разнообразные rulebook-и (baseline, prod, security, repo-server, team-local).
- `policy-plugins/custom/` — кастомные Rego-правила как пример расширения политики.
- `scripts/` и `Makefile` — обёртки под разные сценарии запуска (`render`, `dry-run`, `security`).
- `pipelines/` и `.github/workflows/` — готовые конфигурации для GitHub Actions, GitLab CI, Azure Pipelines, CircleCI, Argo Workflows и Jenkins.
- `docs/advanced-scenarios.md` — углублённые сценарии использования.

## Примеры манифестов

| Сценарий | Файл | Что показывает |
| --- | --- | --- |
| Базовое приложение на Kustomize | `manifests/good/app-kustomize.yaml` | Пинованный `targetRevision`, namespace, автоматический sync.
| Helm с values | `manifests/good/app-helm.yaml` | Работа `spec.source.helm.values`.
| Multi-source | `manifests/advanced/app-multi-source.yaml` | Комбинация Git/Kustomize/Helm в одном приложении.
| Vault plugin | `manifests/advanced/app-plugin-vault.yaml` | `spec.source.plugin` и безопасность секретов.
| Matrix ApplicationSet | `manifests/applicationsets/cluster-matrix.yaml` | `matrix` генератор + строгие `goTemplateOptions`.
| Рендер из репо | `manifests/advanced/app-render-{helm,kustomize}.yaml` | Реальные пути к `render-sources/` для `--render`.
| Проблемные практики | `manifests/bad/*.yaml` | Плавающие ревизии, пропущенные namespaces, агрессивные `ignoreDifferences`.

## Конфигурации линтера

| Файл | Назначение |
| --- | --- |
| `argocd-lint-config/baseline.yaml` | Общий минимальный набор для всех команд.
| `argocd-lint-config/prod-strict.yaml` | Строгий прод c `--render` и плагинами.
| `argocd-lint-config/team-payments.yaml` | Пример override по путям dev/prod для конкретной команды.
| `argocd-lint-config/security.yaml` | Подключение кастомных Rego-плагинов и ужесточение governance-правил.
| `argocd-lint-config/repo-server.yaml` | Базовая конфигурация для Config Management Plugin в repo-server.
| `argocd-lint-config/local-development.yaml` | Облегчённые проверки для экспериментальных директорий.

Подключение конфигов:

```bash
argocd-lint manifests --rules argocd-lint-config/team-payments.yaml --severity-threshold=warn
argocd-lint manifests/advanced/app-plugin-vault.yaml --rules argocd-lint-config/security.yaml --plugin-dir policy-plugins/custom --format json
```

## Скрипты и Makefile

| Команда | Что делает |
| --- | --- |
| `make lint` | Базовый запуск по всему каталогу `manifests/`.
| `make lint-render` | Включает `--render` и автоматически подтягивает `helm`/`kustomize`, если они доступны.
| `make lint-security` | Проверяет манифесты с учётом кастомных Rego-плагинов безопасности.
| `make lint-dry-run` | Комбинирует `--render` с `--dry-run` (по умолчанию `kubeconform`).

Скрипты в `scripts/` можно вызывать напрямую и комбинировать с флагами `argocd-lint`, например:

```bash
DRY_RUN_MODE=server KUBECONFIG=$HOME/.kube/prod scripts/lint_with_dry_run.sh --format sarif
scripts/lint_security.sh --severity-threshold=info --appsets-only
```

## CI/CD пайплайны

- GitHub Actions: `.github/workflows/lint.yaml` запускает матрицу сценариев (baseline, render, security, dry-run) и выгружает SARIF.
- GitLab CI: `pipelines/gitlab-ci.yml` кеширует Go и сохраняет JSON отчёт.
- Jenkins: `pipelines/Jenkinsfile` показывает stages с установкой инструментов и архивированием артефактов.
- Azure Pipelines: `pipelines/azure-pipelines.yml` выполняет несколько прогонов и публикует результат.
- CircleCI: `pipelines/circleci.yml` демонстрирует установку через orbs и сохранение артефактов.
- Argo Workflows: `pipelines/argo-workflows.yaml` реализует DAG из трёх шагов для запуска `argocd-lint` внутри Kubernetes.

Дополнительные мысли:

- Добавьте шаги загрузки SARIF/JSON в собственные пайплайны для визуализации в QA-инструментах.
- Перенесите соответствующие строки в pre-sync hooks Argo CD или в repo-server CMP.

## Дальше

1. Пройдите по `docs/advanced-scenarios.md`, чтобы воспроизвести более сложные сценарии.
2. Настройте собственные overrides и плагины в `argocd-lint-config/` и `policy-plugins/`.
3. Интегрируйте понравившийся пайплайн из `pipelines/` в ваш GitOps-репозиторий.
4. Экспериментируйте с `manifests/bad/`, чтобы увидеть, как линтер подсвечивает нарушения и как меняются сообщения при переключении rulebook-ов.
