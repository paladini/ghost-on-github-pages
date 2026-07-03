#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=includes/lib/common.sh
source "${SCRIPT_DIR}/includes/lib/common.sh"

DRY_RUN=0
SKIP_DEPLOY=0
FORCE=0

usage() {
	echo "Usage: migrate.sh [--dry-run] [--skip-deploy] [--force]"
	echo ""
	echo "  Upgrades an existing v2 (Classic) setup to v3."
	echo "  A backup of ~/.ghost is created automatically."
}

while [ $# -gt 0 ]; do
	case "$1" in
		--dry-run)
			DRY_RUN=1
			shift
			;;
		--skip-deploy)
			SKIP_DEPLOY=1
			shift
			;;
		--force)
			FORCE=1
			shift
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

"${SCRIPT_DIR}/scripts/migrate-check.sh"

BACKUP_PATH="${HOME}/.ghost.backup.$(date +%Y%m%d-%H%M%S)"

info "This will upgrade your blog setup from Classic (v2) to v3."
info "A backup will be saved before any changes are made."

if [ "$FORCE" -eq 0 ]; then
	read -r -p "Continue? [y/N] " answer
	case "$answer" in
		[yY]|[yY][eE][sS]) ;;
		*) info "Migration cancelled."; exit 0 ;;
	esac
fi

if [ "$DRY_RUN" -eq 1 ]; then
	info "[dry-run] Would back up ${GHOST_INSTALL} to ${BACKUP_PATH}"
	info "[dry-run] Would install ghost-static-site-generator (gssg)"
	info "[dry-run] Would replace deploy.sh and add lib/common.sh"
	info "[dry-run] Would create or update ${DEPLOY_CONF}"
	[ "$SKIP_DEPLOY" -eq 0 ] && info "[dry-run] Would run first publish with v3"
	exit 0
fi

info "Creating backup at ${BACKUP_PATH}..."
cp -a "$GHOST_INSTALL" "$BACKUP_PATH"
info "Backup saved."

require_command npm
ensure_gssg

cp "${SCRIPT_DIR}/includes/deploy.sh" "${GHOST_INSTALL}/"
cp "${SCRIPT_DIR}/includes/uninstall.sh" "${GHOST_INSTALL}/"
mkdir -p "${GHOST_INSTALL}/lib"
cp "${SCRIPT_DIR}/includes/lib/common.sh" "${GHOST_INSTALL}/lib/common.sh"
mkdir -p "${GHOST_INSTALL}/scripts"
cp "${SCRIPT_DIR}/scripts/validate-static.sh" "${GHOST_INSTALL}/scripts/"
chmod +x "${GHOST_INSTALL}/scripts/validate-static.sh"
chmod +x "${GHOST_INSTALL}/deploy.sh"
chmod +x "${GHOST_INSTALL}/uninstall.sh"

if [ -f "${GHOST_PATH}/.git/config" ] && [ ! -f "$DEPLOY_CONF" ]; then
	REMOTE_URL="$(git -C "$GHOST_PATH" remote get-url origin 2>/dev/null || true)"
	if [ -n "$REMOTE_URL" ]; then
		case "$REMOTE_URL" in
			*github.com*)
				GH_USERNAME="$(echo "$REMOTE_URL" | sed -E 's#.*github.com[:/]([^/]+)/.*#\1#')"
				GH_REPO="$(echo "$REMOTE_URL" | sed -E 's#.*github.com[:/][^/]+/([^/.]+).*#\1#')"
				PRODUCTION_DOMAIN="$(production_domain_for "$GH_USERNAME" "$GH_REPO")"
				save_deploy_conf "default" "$GH_USERNAME" "$GH_REPO" "$REMOTE_URL" "$PRODUCTION_DOMAIN"
				info "Saved your GitHub settings from the existing repository."
				;;
		esac
	fi
fi

configure_ghost_url
info "Migration complete!"
info "Backup location: ${BACKUP_PATH}"
info "See docs/MIGRATION.md#after-migration for next steps."

if [ "$SKIP_DEPLOY" -eq 0 ]; then
	echo ""
	read -r -p "Publish your blog now with the new version? [Y/n] " answer
	case "$answer" in
		[nN]|[nN][oO])
			info "Skipped publish. Run: cd ~/.ghost && ./deploy.sh"
			;;
		*)
			(cd "$GHOST_INSTALL" && ./deploy.sh)
			;;
	esac
fi
