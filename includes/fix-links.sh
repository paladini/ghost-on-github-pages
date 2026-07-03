#!/usr/bin/env bash
# Rewrite localhost URLs in static HTML without corrupting image file names (#17).

set -euo pipefail

STATIC_DIR="${1:-}"
GH_USERNAME="${2:-}"
GH_REPO="${3:-}"

if [ -z "$STATIC_DIR" ] || [ -z "$GH_USERNAME" ]; then
	echo "[ERROR] Usage: fix-links.sh STATIC_DIR GITHUB_USERNAME [REPO_NAME]" >&2
	exit 1
fi

if [ ! -d "$STATIC_DIR" ]; then
	echo "[ERROR] Static folder not found: $STATIC_DIR" >&2
	exit 1
fi

TARGET_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/lib" && pwd)"
# shellcheck source=lib/common.sh
source "${TARGET_PATH}/common.sh"

PRODUCTION_PATH="$(production_url_path_for "$GH_USERNAME" "$GH_REPO")"
PRODUCTION_URL="$(production_domain_for "$GH_USERNAME" "$GH_REPO")"

# Only replace full localhost URL prefixes (http/https, ports 2368 and 2373).
fix_file() {
	local file="$1"
	if ! command -v perl >/dev/null 2>&1; then
		die "perl is required for safe link fixing. Install perl or upgrade to version 3."
	fi

	perl -pi -e "
		s#https?://localhost:2373/?#${PRODUCTION_URL}/#g;
		s#https?://localhost:2368/?#${PRODUCTION_URL}/#g;
		s#//localhost:2373/?#//${PRODUCTION_PATH}/#g;
		s#//localhost:2368/?#//${PRODUCTION_PATH}/#g;
	" "$file"
}

while IFS= read -r -d '' html_file; do
	fix_file "$html_file"
done < <(find "$STATIC_DIR" -name '*.html' -type f -print0)

echo "[OK] Links updated for GitHub Pages (${PRODUCTION_URL})."
