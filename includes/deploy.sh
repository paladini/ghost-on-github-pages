#!/usr/bin/env bash

set -euo pipefail

HOME_PATH="${HOME}"
GHOST_INSTALL="${HOME_PATH}/.ghost"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

SITE_NAME="default"

usage() {
	echo "Usage: deploy.sh [--site SITE_NAME]"
	echo ""
	echo "  Publishes your local blog to GitHub Pages (Classic / buster)."
}

while [ $# -gt 0 ]; do
	case "$1" in
		--site)
			SITE_NAME="${2:-}"
			shift 2
			;;
		-h|--help)
			usage
			exit 0
			;;
		*)
			die "Unknown option: $1"
			;;
	esac
done

if [ -n "${SITE_NAME}" ] && [ "${SITE_NAME}" != "default" ]; then
	if load_site_conf "${SITE_NAME}"; then
		info "Using site profile: ${SITE_NAME}"
	else
		die "Site profile '${SITE_NAME}' was not found in ${SITES_CONF}. See docs/legacy/MULTI-REPO.md"
	fi
else
	prompt_deploy_settings
fi

ensure_buster
ensure_ghost_running

cd "$GHOST_PATH" || die "Could not open Ghost folder."
info "Creating static files from your blog. This may take a minute..."
buster generate --domain="$GHOST_SERVER_URL"

"${SCRIPT_DIR}/fix-links.sh" "${GHOST_PATH}/static" "$GH_USERNAME" "$GH_REPO"

INCLUDE_INDEX="${SCRIPT_DIR}/index.html"
prepare_publish_dir "$GHOST_PATH" "$INCLUDE_INDEX"

"${GHOST_INSTALL}/scripts/validate-static.sh" "$PUBLISH_PATH/static"

cd "$PUBLISH_PATH" || die "Could not open publish folder."

if [ ! -d .git ]; then
	info "Setting up publishing for the first time..."
	git init
	git remote add origin "$REMOTE_URL" 2>/dev/null || git remote set-url origin "$REMOTE_URL"
	git add -A
	git commit -m "First publish to GitHub Pages using Ghost (Classic)."
	git push -u origin master:master master:gh-pages -f
	info "Done! Your blog should appear at ${PRODUCTION_DOMAIN} within about 10 minutes."
else
	info "Publishing your latest changes..."
	git add -A
	if git diff --cached --quiet; then
		warn "No changes to publish. If you edited your blog, make sure Ghost is running and try again."
		exit 0
	fi
	git commit -m "Blog update at $(date)"
	git push origin master:master master:gh-pages -f
	info "Done! Check your live blog at ${PRODUCTION_DOMAIN}"
fi
