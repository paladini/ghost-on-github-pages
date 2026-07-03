#!/usr/bin/env bash
# Shared helpers for install, deploy, and migrate scripts.

GHOST_INSTALL="${HOME}/.ghost"
GHOST_PATH="${GHOST_INSTALL}/current"
GHOST_PORT="${GHOST_PORT:-2373}"
GHOST_SERVER_URL="http://localhost:${GHOST_PORT}"
PUBLISH_PATH="${GHOST_INSTALL}/publish"
DEPLOY_CONF="${GHOST_INSTALL}/deploy.conf"
SITES_CONF="${GHOST_INSTALL}/sites.conf"
SCRIPT_VERSION="3.0.0"

die() {
	echo "[ERROR] $*" >&2
	exit 1
}

info() {
	echo "[INFO] $*"
}

warn() {
	echo "[WARN] $*"
}

require_command() {
	if ! command -v "$1" >/dev/null 2>&1; then
		die "'$1' is not installed. See docs/v3/REQUIREMENTS.md for help."
	fi
}

ghost_current_ready() {
	[ -d "${GHOST_PATH}" ] && [ -f "${GHOST_PATH}/config.development.json" -o -L "${GHOST_PATH}" ]
}

production_domain_for() {
	local username="$1"
	local repo="$2"

	if [ -z "$repo" ] || [ "$repo" = "${username}.github.io" ]; then
		echo "https://${username}.github.io"
	else
		echo "https://${username}.github.io/${repo}"
	fi
}

gssg_subdir_for() {
	local username="$1"
	local repo="$2"

	if [ -z "$repo" ] || [ "$repo" = "${username}.github.io" ]; then
		echo ""
	else
		echo "$repo"
	fi
}

run_gssg() {
	local production_domain="$1"
	local subdir="$2"
	local dest="${GHOST_PATH}/static"

	rm -rf "$dest"
	mkdir -p "$dest"

	info "Creating static files from your blog. This may take a minute..."

	if [ -n "$subdir" ]; then
		gssg --domain "$GHOST_SERVER_URL" --productionDomain "$production_domain" --dest "$dest" --subDir "$subdir" --fail-on-error
	else
		gssg --domain "$GHOST_SERVER_URL" --productionDomain "$production_domain" --dest "$dest" --fail-on-error
	fi
}

prepare_publish_dir() {
	local source_root="$1"

	rm -rf "$PUBLISH_PATH"
	mkdir -p "$PUBLISH_PATH"

	if [ -f "${source_root}/index.html" ]; then
		cp "${source_root}/index.html" "$PUBLISH_PATH/"
	fi

	if [ -d "${source_root}/static" ]; then
		cp -R "${source_root}/static" "$PUBLISH_PATH/"
	fi

	if [ ! -d "${PUBLISH_PATH}/static" ]; then
		die "Static files were not created. Is your blog running at ${GHOST_SERVER_URL}?"
	fi
}

save_deploy_conf() {
	local site_name="$1"
	local gh_username="$2"
	local gh_repo="$3"
	local remote_url="$4"
	local production_domain="$5"

	cat > "$DEPLOY_CONF" <<EOF
# Ghost on GitHub Pages deploy settings (v${SCRIPT_VERSION})
SITE_NAME=${site_name}
GH_USERNAME=${gh_username}
GH_REPO=${gh_repo}
REMOTE_URL=${remote_url}
PRODUCTION_DOMAIN=${production_domain}
GHOST_PORT=${GHOST_PORT}
EOF
	chmod 600 "$DEPLOY_CONF"
}

load_deploy_conf() {
	if [ ! -f "$DEPLOY_CONF" ]; then
		return 1
	fi
	# shellcheck disable=SC1090
	source "$DEPLOY_CONF"
	return 0
}

load_site_conf() {
	local site_name="$1"
	local found=0
	local in_section=0

	if [ ! -f "$SITES_CONF" ]; then
		return 1
	fi

	while IFS= read -r line || [ -n "$line" ]; do
		case "$line" in
			"[$site_name]")
				in_section=1
				found=1
				;;
			"["*)
				in_section=0
				;;
			*)
				if [ "$in_section" -eq 1 ] && [[ "$line" == *"="* ]]; then
					export "${line%%=*}=${line#*=}"
				fi
				;;
		esac
	done < "$SITES_CONF"

	[ "$found" -eq 1 ] || return 1
	GH_USERNAME="${gh_username:-}"
	GH_REPO="${gh_repo:-}"
	REMOTE_URL="${remote_url:-}"
	PRODUCTION_DOMAIN="${production_domain:-}"
	return 0
}

prompt_deploy_settings() {
	if ! load_deploy_conf; then
		echo ""
		echo " ---------- We need a few details about your GitHub blog ---------- "
		echo ""
		read -r -p "What is your GitHub username? " GH_USERNAME
		read -r -p "What is your repository name? (example: my-blog) " GH_REPO
		read -r -p "What is your repository URL? (example: git@github.com:you/my-blog.git) " REMOTE_URL
		PRODUCTION_DOMAIN="$(production_domain_for "$GH_USERNAME" "$GH_REPO")"
		save_deploy_conf "default" "$GH_USERNAME" "$GH_REPO" "$REMOTE_URL" "$PRODUCTION_DOMAIN"
	fi
}

ensure_gssg() {
	require_command npm
	if command -v gssg >/dev/null 2>&1; then
		return 0
	fi
	info "Installing the tool that turns your blog into a static website..."
	npm install -g ghost-static-site-generator || die "Could not install ghost-static-site-generator. Check your internet connection and try again."
}

ensure_ghost_running() {
	if ! ghost_current_ready; then
		die "Your blog folder is not set up yet. Run install.sh first."
	fi

	cd "$GHOST_INSTALL" || die "Could not open your blog folder at ${GHOST_INSTALL}"
	if ! ghost status 2>/dev/null | grep -q "running"; then
		info "Starting your local blog..."
		ghost start --enable || die "Could not start Ghost. Run: cd ~/.ghost && ghost start"
	fi
}

configure_ghost_url() {
	if ghost_current_ready; then
		cd "$GHOST_INSTALL" || return 0
		ghost config url "$GHOST_SERVER_URL" >/dev/null 2>&1 || true
	fi
}
