#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLAN_FILE="${PLAN_FILE:-${ROOT_DIR}/manifests/applicationsets/cluster-matrix.yaml}"
ARGOCD_VERSION="${ARGOCD_VERSION:-v2.10.0}"

if [[ ! -f "${PLAN_FILE}" ]]; then
  echo "ApplicationSet file not found: ${PLAN_FILE}" >&2
  exit 1
fi

argocd-lint applicationset plan \
  --file "${PLAN_FILE}" \
  --argocd-version "${ARGOCD_VERSION}" \
  "$@"
