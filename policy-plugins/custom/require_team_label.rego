package argocd_lint.custom.require_team_label

metadata := {
  "id": "RG_TEAM_LABEL",
  "description": "Applications and ApplicationSets must declare an ownership label",
  "severity": "warn",
  "category": "Ownership",
  "applies_to": ["Application", "ApplicationSet"],
  "help_url": "https://github.com/harchuk/argocd-lint-example/docs/advanced-scenarios.md#сценарий-3",
}

applies {
  input.kind == "Application"
}

applies {
  input.kind == "ApplicationSet"
}

has_team_label {
  input.metadata.labels.team != ""
}

has_team_label {
  input.metadata.labels["app.kubernetes.io/managed-by"] != ""
}

deny[f] {
  not has_team_label

  f := {
    "message": "Укажите метку team или app.kubernetes.io/managed-by, чтобы зафиксировать владельца",
    "resource_name": input.metadata.name,
    "resource_kind": input.kind,
    "rule_id": metadata.id,
  }
}
