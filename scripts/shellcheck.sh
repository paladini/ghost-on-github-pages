#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v shellcheck >/dev/null 2>&1; then
	echo "[WARN] shellcheck is not installed; skipping shell script lint."
	exit 0
fi

# common.sh is listed explicitly; -e SC1091 avoids false positives on source= directives.
shellcheck -x -P "${ROOT}" -P "${ROOT}/includes" -e SC1091 \
	"${ROOT}/install.sh" \
	"${ROOT}/migrate.sh" \
	"${ROOT}/includes/deploy.sh" \
	"${ROOT}/includes/uninstall.sh" \
	"${ROOT}/includes/lib/common.sh" \
	"${ROOT}/scripts/"*.sh

echo "[OK] shellcheck passed."
