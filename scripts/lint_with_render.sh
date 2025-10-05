#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="${ROOT_DIR}/argocd-lint-config/prod-strict.yaml"

helm_bin="${HELM_BINARY:-$(command -v helm || true)}"
kustomize_bin="${KUSTOMIZE_BINARY:-$(command -v kustomize || true)}"

declare -a render_args=()
if [[ -n "${helm_bin}" ]]; then
  render_args+=("--helm-binary" "${helm_bin}")
fi
if [[ -n "${kustomize_bin}" ]]; then
  render_args+=("--kustomize-binary" "${kustomize_bin}")
fi

extra_args=("$@")

argocd-lint "${ROOT_DIR}/manifests" \
  --rules "${CONFIG_FILE}" \
  --render \
  "${render_args[@]}" \
  "${extra_args[@]}"
