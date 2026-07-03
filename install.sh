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
	echo "  Sets up Ghost on your computer (Classic version with buster)."
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

info "Ghost on GitHub Pages Classic v${SCRIPT_VERSION}"
info "This may take several minutes. Please keep this window open."
warn "Classic requires Python 2 and buster. For fewer dependencies, see version 3."

if [ -d "$GHOST_INSTALL" ] && ! ghost_current_ready; then
	die "A partial install was found at ${GHOST_INSTALL}. Remove that folder or fix the install, then try again."
fi

local_setup() {
	if ghost_current_ready; then
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
		die "Ghost could not be installed. See docs/legacy/TROUBLESHOOTING.md"
	fi

	if ! ghost_current_ready; then
		die "Ghost install did not finish correctly. See docs/legacy/TROUBLESHOOTING.md"
	fi
}

local_deps() {
	info "Installing buster (static site generator for Classic)..."

	local success=0

	if command -v pip2.7 >/dev/null 2>&1; then
		pip2.7 install buster && success=1
	elif command -v pip2 >/dev/null 2>&1; then
		pip2 install buster && success=1
	fi

	if [ "$success" -eq 0 ]; then
		warn "pip2 was not found. Trying to install Python 2 pip..."
		if [ "$(uname)" = "Darwin" ]; then
			sudo easy_install pip 2>/dev/null || true
			sudo pip2 install buster 2>/dev/null || sudo pip install buster
		elif [ "$(uname -s | cut -c1-5)" = "Linux" ]; then
			sudo apt-get install -y python-setuptools python-dev build-essential 2>/dev/null || true
			sudo easy_install pip 2>/dev/null || true
			sudo pip2 install buster 2>/dev/null || sudo pip install buster
		else
			die "Could not install buster. See docs/legacy/REQUIREMENTS.md (Python 2 + pip2 required)."
		fi
	fi

	if ! command -v buster >/dev/null 2>&1; then
		die "buster is still not available. Install Python 2 and pip2, then run install.sh again. See docs/legacy/REQUIREMENTS.md"
	fi

	info "buster is ready."
}

move_includes() {
	if ! ghost_current_ready; then
		die "Ghost is not ready yet. Install cannot continue."
	fi

	cp "${ABSOLUTE_PATH}/includes/deploy.sh" "${GHOST_INSTALL}/"
	cp "${ABSOLUTE_PATH}/includes/uninstall.sh" "${GHOST_INSTALL}/"
	cp "${ABSOLUTE_PATH}/includes/fix-links.sh" "${GHOST_INSTALL}/"
	mkdir -p "${GHOST_INSTALL}/lib"
	cp "${ABSOLUTE_PATH}/includes/lib/common.sh" "${GHOST_INSTALL}/lib/common.sh"
	mkdir -p "${GHOST_INSTALL}/scripts"
	cp "${ABSOLUTE_PATH}/scripts/validate-static.sh" "${GHOST_INSTALL}/scripts/"
	chmod +x "${GHOST_INSTALL}/deploy.sh"
	chmod +x "${GHOST_INSTALL}/uninstall.sh"
	chmod +x "${GHOST_INSTALL}/fix-links.sh"
	chmod +x "${GHOST_INSTALL}/scripts/validate-static.sh"
	cp "${ABSOLUTE_PATH}/includes/index.html" "${GHOST_PATH}/"
	cp "${ABSOLUTE_PATH}/includes/gitignore.base" "${GHOST_PATH}/"
	cp "${ABSOLUTE_PATH}/includes/gitignore.base" "${GHOST_PATH}/.gitignore"
}

local_run() {
	cd "$GHOST_INSTALL" || die "Could not open your blog folder."
	info "Starting your local blog..."
	ghost start --enable || die "Could not start Ghost. Try: cd ~/.ghost && ghost start"
	configure_ghost_url
}

local_setup
local_deps
move_includes
local_run

info "Install finished!"
info "Open your blog editor at: http://localhost:${GHOST_PORT}/ghost"
info "Set your site URL to http://localhost:${GHOST_PORT} in Ghost Admin if publish ever hangs."
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
