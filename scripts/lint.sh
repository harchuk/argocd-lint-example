#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="${ROOT_DIR}/argocd-lint-config/baseline.yaml"

extra_args=("$@")

argocd-lint "${ROOT_DIR}/manifests" --rules "${CONFIG_FILE}" "${extra_args[@]}"
