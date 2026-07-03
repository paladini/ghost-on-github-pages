#!/usr/bin/env bash

set -euo pipefail

STATIC_DIR="${1:-static}"
FAILED=0

if [ ! -d "$STATIC_DIR" ]; then
	echo "[ERROR] Static folder not found: $STATIC_DIR" >&2
	exit 1
fi

search_pattern() {
	local pattern="$1"
	if command -v rg >/dev/null 2>&1; then
		rg -q "$pattern" "$STATIC_DIR"
	else
		grep -R -E -q "$pattern" "$STATIC_DIR"
	fi
}

if search_pattern 'localhost:(2368|2373)'; then
	echo "[ERROR] Found links pointing to localhost in published files." >&2
	FAILED=1
fi

if search_pattern '\.jpegg|\.jpegpg|\.jpegjpg'; then
	echo "[ERROR] Found broken image paths in published files." >&2
	FAILED=1
fi

if [ "$FAILED" -ne 0 ]; then
	echo "[ERROR] Static site validation failed. See docs/legacy/TROUBLESHOOTING.md" >&2
	exit 1
fi

echo "[OK] Static site validation passed."
