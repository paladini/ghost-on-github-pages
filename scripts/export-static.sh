#!/usr/bin/env bash
# Create static files from a running Ghost (Ghost-CLI or Docker). Does not push to GitHub.

set -euo pipefail

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
	ABSOLUTE_PATH="$(cd -P "$(dirname "$SOURCE")" && pwd)"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$ABSOLUTE_PATH/$SOURCE"
done
ABSOLUTE_PATH="$(cd -P "$(dirname "$SOURCE")" && pwd)"

if [ -f "${ABSOLUTE_PATH}/../includes/lib/common.sh" ]; then
	ROOT="$(cd "${ABSOLUTE_PATH}/.." && pwd)"
	# shellcheck source=includes/lib/common.sh
	source "${ROOT}/includes/lib/common.sh"
	VALIDATE_SCRIPT="${ROOT}/scripts/validate-static.sh"
	INCLUDE_INDEX="${ROOT}/includes/index.html"
else
	# Copied into ~/.ghost/scripts by compose-setup.sh / install.sh
	# shellcheck source=lib/common.sh
	source "${ABSOLUTE_PATH}/../lib/common.sh"
	VALIDATE_SCRIPT="${GHOST_INSTALL}/scripts/validate-static.sh"
	INCLUDE_INDEX="${GHOST_PATH}/index.html"
fi

usage() {
	echo "Usage: export-static.sh"
	echo ""
	echo "  Reads Ghost at http://localhost:${GHOST_PORT:-2373} and writes static files."
	echo "  Set GH_USERNAME and GH_REPO (or PRODUCTION_DOMAIN) before running."
	echo "  See docs/v3/CI.md"
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
	usage
	exit 0
fi

GH_USERNAME="${GH_USERNAME:-}"
GH_REPO="${GH_REPO:-}"
PRODUCTION_DOMAIN="${PRODUCTION_DOMAIN:-}"

if [ -z "$PRODUCTION_DOMAIN" ]; then
	if [ -z "$GH_USERNAME" ]; then
		die "Set PRODUCTION_DOMAIN or GH_USERNAME (and GH_REPO). See docs/v3/CI.md"
	fi
	PRODUCTION_DOMAIN="$(production_domain_for "$GH_USERNAME" "$GH_REPO")"
fi

SUBDIR="$(gssg_subdir_for "$GH_USERNAME" "$GH_REPO")"

require_command wget
ensure_gssg
ensure_ghost_running

run_gssg "$PRODUCTION_DOMAIN" "$SUBDIR"
prepare_publish_dir "${GHOST_PATH}"
if [ -f "$INCLUDE_INDEX" ]; then
	cp "$INCLUDE_INDEX" "$PUBLISH_PATH/index.html"
fi

"$VALIDATE_SCRIPT" "$PUBLISH_PATH/static"

info "Static files are in ${PUBLISH_PATH}"
info "Live URL will be ${PRODUCTION_DOMAIN}"
