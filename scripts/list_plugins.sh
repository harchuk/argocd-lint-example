#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_DIR="${PLUGIN_DIR:-${ROOT_DIR}/policy-plugins/custom}"

argocd-lint plugins list --dir "${PLUGIN_DIR}" "$@"
