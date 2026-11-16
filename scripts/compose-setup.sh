#!/usr/bin/env bash
# Copy publish scripts into ~/.ghost for the Docker Compose path.
# Does not install Ghost-CLI; start Ghost with: docker compose up -d

set -euo pipefail

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
	ABSOLUTE_PATH="$(cd -P "$(dirname "$SOURCE")" && pwd)"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$ABSOLUTE_PATH/$SOURCE"
done
ABSOLUTE_PATH="$(cd -P "$(dirname "$SOURCE")" && pwd)"
ROOT="$(cd "${ABSOLUTE_PATH}/.." && pwd)"

# shellcheck source=includes/lib/common.sh
source "${ROOT}/includes/lib/common.sh"

usage() {
	echo "Usage: compose-setup.sh"
	echo ""
	echo "  Prepares ~/.ghost for Ghost running in Docker Compose."
	echo "  Then run: docker compose up -d"
	echo "  See docs/v3/DOCKER.md"
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
	usage
	exit 0
fi

if [ -d "${GHOST_PATH}" ] && [ -L "${GHOST_PATH}" ]; then
	die "A Ghost-CLI install already exists at ${GHOST_INSTALL}. Use that, or move it aside before using Compose."
fi

info "Preparing blog folder at ${GHOST_INSTALL}..."
mkdir -p "${GHOST_INSTALL}/content" "${GHOST_PATH}" "${GHOST_INSTALL}/scripts"

cp "${ROOT}/includes/deploy.sh" "${GHOST_INSTALL}/"
cp "${ROOT}/includes/uninstall.sh" "${GHOST_INSTALL}/"
mkdir -p "${GHOST_INSTALL}/lib"
# Copy contents. `cp -R src dest` nests src inside dest when dest already exists.
cp -R "${ROOT}/includes/lib/." "${GHOST_INSTALL}/lib/"
cp "${ROOT}/scripts/validate-static.sh" "${GHOST_INSTALL}/scripts/"
cp "${ROOT}/scripts/export-static.sh" "${GHOST_INSTALL}/scripts/"
cp "${ROOT}/compose.yaml" "${GHOST_INSTALL}/compose.yaml"
if [ -f "${ROOT}/.env.example" ]; then
	cp "${ROOT}/.env.example" "${GHOST_INSTALL}/.env.example"
fi
cp "${ROOT}/includes/index.html" "${GHOST_PATH}/"
cp "${ROOT}/includes/gitignore.base" "${GHOST_PATH}/.gitignore"
chmod +x "${GHOST_INSTALL}/deploy.sh" "${GHOST_INSTALL}/uninstall.sh"
chmod +x "${GHOST_INSTALL}/scripts/validate-static.sh" "${GHOST_INSTALL}/scripts/export-static.sh"

touch "${GHOST_INSTALL}/.docker"

info "Done. Start Ghost with:"
info "  cd ${ROOT} && docker compose up -d"
info "  # or: cd ${GHOST_INSTALL} && docker compose up -d"
info "Open the editor at: ${GHOST_SERVER_URL}/ghost"
info "When you are ready to go live: cd ~/.ghost && ./deploy.sh"
