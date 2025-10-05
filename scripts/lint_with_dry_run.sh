#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="${ROOT_DIR}/argocd-lint-config/prod-strict.yaml"

DRY_RUN_MODE="${DRY_RUN_MODE:-kubeconform}"
KUBECONFIG_PATH="${KUBECONFIG:-}" # optional when using server-side dry-run

ARGS=("${ROOT_DIR}/manifests" --rules "${CONFIG_FILE}" --render --dry-run="${DRY_RUN_MODE}")

if [[ -n "${KUBECONFIG_PATH}" ]]; then
  ARGS+=(--kubeconfig "${KUBECONFIG_PATH}")
fi

argocd-lint "${ARGS[@]}" "$@"
