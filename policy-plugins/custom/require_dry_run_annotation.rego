package argocd_lint.custom.require_dry_run_annotation

metadata := {
  "id": "RG_DRY_RUN",
  "description": "Production resources should record dry-run configuration in CI",
  "severity": "info",
  "category": "Safety",
  "applies_to": ["Application", "ApplicationSet"],
}

applies {
  input.metadata.labels.environment == "prod"
}

deny[f] {
  applies
  not input.metadata.annotations["argocd-lint.io/ci-dry-run"]

  f := {
    "message": "Добавьте аннотацию argocd-lint.io/ci-dry-run, чтобы зафиксировать стратегию dry-run",
    "resource_name": input.metadata.name,
    "resource_kind": input.kind,
    "rule_id": metadata.id,
    "severity": "warn",
  }
}
