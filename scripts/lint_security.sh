#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="${ROOT_DIR}/argocd-lint-config/security.yaml"
PLUGIN_DIR="${ROOT_DIR}/policy-plugins/custom"

argocd-lint "${ROOT_DIR}/manifests" \
  --rules "${CONFIG_FILE}" \
  --plugin-dir "${PLUGIN_DIR}" \
  "$@"
