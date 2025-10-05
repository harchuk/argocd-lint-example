package argocd_lint.custom.require_dry_run_annotation

violation["DRY_RUN_RECOMMENDED"] {
  input.kind == "Application"
  input.metadata.labels.environment == "prod"
  not input.metadata.annotations["argocd-lint.io/ci-dry-run"]
}

violation["DRY_RUN_RECOMMENDED"] {
  input.kind == "ApplicationSet"
  input.metadata.labels.environment == "prod"
  not input.metadata.annotations["argocd-lint.io/ci-dry-run"]
}
