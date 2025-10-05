package argocd_lint.custom.require_team_label

# Fail when Applications or ApplicationSets miss essential ownership metadata
violation["TEAM_LABEL_REQUIRED"] {
  input.kind == "Application"
  not has_team_label
}

violation["TEAM_LABEL_REQUIRED"] {
  input.kind == "ApplicationSet"
  not has_team_label
}

has_team_label {
  input.metadata.labels.team != ""
}

has_team_label {
  input.metadata.labels["app.kubernetes.io/managed-by"] != ""
}
