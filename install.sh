#!/usr/bin/env bash

set -euo pipefail

HOME_PATH="${HOME}"
GHOST_INSTALL="${HOME_PATH}/.ghost"
GHOST_PORT="${GHOST_PORT:-2373}"

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
	ABSOLUTE_PATH="$(cd -P "$(dirname "$SOURCE")" && pwd)"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$ABSOLUTE_PATH/$SOURCE"
done
ABSOLUTE_PATH="$(cd -P "$(dirname "$SOURCE")" && pwd)"

# shellcheck source=includes/lib/common.sh
source "${ABSOLUTE_PATH}/includes/lib/common.sh"

SKIP_DEPLOY=0

usage() {
	echo "Usage: install.sh [--skip-deploy]"
	echo ""
	echo "  Sets up Ghost on your computer and prepares publishing to GitHub Pages."
}

while [ $# -gt 0 ]; do
	case "$1" in
		--skip-deploy)
			SKIP_DEPLOY=1
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

info "Ghost on GitHub Pages v${SCRIPT_VERSION}"
info "This may take several minutes. Please keep this window open."

require_command node
require_command npm
require_command wget

if [ -d "$GHOST_INSTALL" ] && [ ! -d "${GHOST_PATH}" ]; then
	die "A partial install was found at ${GHOST_INSTALL}. Run ./migrate.sh if upgrading from v2, or remove that folder and try again."
fi

local_setup() {
	if [ -d "${GHOST_PATH}" ]; then
		info "Your blog folder already exists at ${GHOST_INSTALL}"
		return 0
	fi

	info "Creating your blog folder at ${GHOST_INSTALL}..."
	mkdir -p "$GHOST_INSTALL"
	cd "$GHOST_INSTALL" || die "Could not create your blog folder."

	info "Installing Ghost (the blogging software)..."
	npm install -g ghost-cli@latest

	info "Setting up Ghost on your computer..."
	if ! ghost install local --no-start --enable --port "$GHOST_PORT"; then
		die "Ghost could not be installed. See docs/TROUBLESHOOTING.md"
	fi

	if ! ghost_current_ready; then
		die "Ghost install did not finish correctly. See docs/TROUBLESHOOTING.md"
	fi
}

move_includes() {
	if ! ghost_current_ready; then
		die "Ghost is not ready yet. Install cannot continue."
	fi

	cp "${ABSOLUTE_PATH}/includes/deploy.sh" "${GHOST_INSTALL}/"
	cp "${ABSOLUTE_PATH}/includes/uninstall.sh" "${GHOST_INSTALL}/"
	cp -R "${ABSOLUTE_PATH}/includes/lib" "${GHOST_INSTALL}/lib"
	mkdir -p "${GHOST_INSTALL}/scripts"
	cp "${ABSOLUTE_PATH}/scripts/validate-static.sh" "${GHOST_INSTALL}/scripts/"
	chmod +x "${GHOST_INSTALL}/scripts/validate-static.sh"
	cp "${ABSOLUTE_PATH}/includes/index.html" "${GHOST_PATH}/"
	cp "${ABSOLUTE_PATH}/includes/gitignore.base" "${GHOST_PATH}/"
	cp "${ABSOLUTE_PATH}/includes/gitignore.base" "${GHOST_PATH}/.gitignore"
	chmod +x "${GHOST_INSTALL}/deploy.sh"
	chmod +x "${GHOST_INSTALL}/uninstall.sh"
}

local_run() {
	cd "$GHOST_INSTALL" || die "Could not open your blog folder."
	info "Starting your local blog..."
	ghost start --enable || die "Could not start Ghost. Try: cd ~/.ghost && ghost start"
	configure_ghost_url
}

ensure_gssg

local_setup
move_includes
local_run

info "Install finished!"
info "Open your blog editor at: http://localhost:${GHOST_PORT}/ghost"
info "When you are ready to go live, run: cd ~/.ghost && ./deploy.sh"

if [ "$SKIP_DEPLOY" -eq 0 ]; then
	echo ""
	read -r -p "Publish your blog to GitHub Pages now? [y/N] " answer
	case "$answer" in
		[yY]|[yY][eE][sS])
			(cd "$GHOST_INSTALL" && ./deploy.sh)
			;;
		*)
			info "Skipped first publish. Run ./deploy.sh anytime from ~/.ghost"
			;;
	esac
fi
