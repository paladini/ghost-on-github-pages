#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v shellcheck >/dev/null 2>&1; then
	echo "[WARN] shellcheck is not installed; skipping shell script lint."
	exit 0
fi

shellcheck -x \
	"${ROOT}/install.sh" \
	"${ROOT}/includes/deploy.sh" \
	"${ROOT}/includes/uninstall.sh" \
	"${ROOT}/includes/fix-links.sh" \
	"${ROOT}/includes/lib/common.sh" \
	"${ROOT}/scripts/"*.sh

echo "[OK] shellcheck passed."
