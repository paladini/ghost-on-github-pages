#!/usr/bin/env bash
# Shared helpers for Classic (v2.x) install and deploy scripts.

GHOST_INSTALL="${HOME}/.ghost"
GHOST_PATH="${GHOST_INSTALL}/current"
GHOST_PORT="${GHOST_PORT:-2373}"
GHOST_SERVER_URL="localhost:${GHOST_PORT}/"
PUBLISH_PATH="${GHOST_INSTALL}/publish"
DEPLOY_CONF="${GHOST_INSTALL}/deploy.conf"
SITES_CONF="${GHOST_INSTALL}/sites.conf"
SCRIPT_VERSION="2.0.2"

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

ghost_current_ready() {
	[ -d "${GHOST_PATH}" ] && { [ -f "${GHOST_PATH}/config.development.json" ] || [ -L "${GHOST_PATH}" ]; }
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

production_url_path_for() {
	local username="$1"
	local repo="$2"

	if [ -z "$repo" ] || [ "$repo" = "${username}.github.io" ]; then
		echo "${username}.github.io"
	else
		echo "${username}.github.io/${repo}"
	fi
}

save_deploy_conf() {
	local site_name="$1"
	local gh_username="$2"
	local gh_repo="$3"
	local remote_url="$4"
	local production_domain="$5"

	cat > "$DEPLOY_CONF" <<EOF
# Ghost on GitHub Pages Classic deploy settings (v${SCRIPT_VERSION})
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

prepare_publish_dir() {
	local source_root="$1"
	local include_index="$2"

	rm -rf "$PUBLISH_PATH"
	mkdir -p "$PUBLISH_PATH"

	if [ -f "$include_index" ]; then
		cp "$include_index" "$PUBLISH_PATH/index.html"
	elif [ -f "${source_root}/index.html" ]; then
		cp "${source_root}/index.html" "$PUBLISH_PATH/index.html"
	fi

	if [ -d "${source_root}/static" ]; then
		cp -R "${source_root}/static" "$PUBLISH_PATH/"
	fi

	if [ ! -d "${PUBLISH_PATH}/static" ]; then
		die "Static files were not created. Is your blog running at http://localhost:${GHOST_PORT}?"
	fi
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
		ghost config url "http://localhost:${GHOST_PORT}" >/dev/null 2>&1 || true
	fi
}

ensure_buster() {
	if command -v buster >/dev/null 2>&1; then
		return 0
	fi
	die "buster is not installed. Run install.sh again or see docs/legacy/REQUIREMENTS.md"
}
