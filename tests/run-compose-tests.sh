#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE="${ROOT}/compose.yaml"
WORKFLOW="${ROOT}/.github/workflows/publish-static.yml"
EXAMPLE="${ROOT}/examples/github/publish-static.yml"
ACTION="${ROOT}/action.yml"
DOCKERFILE="${ROOT}/Dockerfile"
IMAGE_WORKFLOW="${ROOT}/.github/workflows/publish-image.yml"
MARKETPLACE_EXAMPLE="${ROOT}/examples/github/marketplace-action.yml"
FAILED=0

fail() {
	echo "[ERROR] $*" >&2
	FAILED=1
}

require_text() {
	local file="$1"
	local pattern="$2"
	local label="$3"
	if grep -Eq "$pattern" "$file"; then
		echo "[OK] ${label}"
	else
		fail "${label}: expected /${pattern}/ in ${file}"
	fi
}

[ -f "$COMPOSE" ] || fail "missing compose.yaml"
[ -f "$WORKFLOW" ] || fail "missing publish-static.yml"
[ -f "$EXAMPLE" ] || fail "missing examples/github/publish-static.yml"

require_text "$COMPOSE" '^name:[[:space:]]*gogp' "fixed Compose project name"
require_text "$COMPOSE" 'image:[[:space:]]*ghost:6' "official Ghost 6 image"
require_text "$COMPOSE" '\$\{GHOST_PORT:-2373\}:2368' "host port 2373 maps to 2368"
require_text "$COMPOSE" '/var/lib/ghost/content' "content volume mount"
require_text "$COMPOSE" 'database__client:[[:space:]]*sqlite3' "SQLite client"
require_text "$COMPOSE" 'database__connection__filename:[[:space:]]*/var/lib/ghost/content/data/ghost\.db' "SQLite file on the content mount"
require_text "$COMPOSE" 'NODE_ENV:[[:space:]]*development' "development mode"
require_text "$WORKFLOW" 'workflow_call:' "reusable workflow_call trigger"
require_text "$WORKFLOW" 'allow_empty:' "explicit empty-content opt-in"
require_text "$WORKFLOW" 'cancel-in-progress:[[:space:]]*false' "do not cancel an in-progress Pages deploy"
require_text "$WORKFLOW" 'actions/configure-pages@v5' "Pages configuration"
require_text "$WORKFLOW" 'actions/upload-pages-artifact@v3' "Pages artifact upload"
require_text "$WORKFLOW" 'actions/deploy-pages@v5' "Pages deploy"
require_text "$WORKFLOW" 'ghost-static-site-generator' "gssg in CI"
require_text "$WORKFLOW" 'Refusing to publish an empty Ghost site' "missing content fails the export"
require_text "$EXAMPLE" 'uses:[[:space:]]*paladini/ghost-on-github-pages/.github/workflows/publish-static.yml@master' "example calls reusable workflow"
require_text "$ACTION" 'using:[[:space:]]*composite' "Marketplace action is composite"
require_text "$ACTION" 'scripts/export-static.sh' "Marketplace action exports with the shared script"
require_text "$ACTION" 'Refusing to publish an empty Ghost site' "Marketplace action refuses a missing content folder"
require_text "$ACTION" 'actions/upload-pages-artifact@v3' "Marketplace action uploads the Pages artifact"
require_text "$MARKETPLACE_EXAMPLE" 'uses:[[:space:]]*paladini/ghost-on-github-pages@master' "Marketplace example calls the root action"
require_text "$MARKETPLACE_EXAMPLE" 'actions/deploy-pages@v5' "Marketplace example deploys in a second job"
require_text "$DOCKERFILE" '^FROM node:' "exporter image is a Node toolchain, not Ghost"
require_text "$DOCKERFILE" 'ghost-static-site-generator' "exporter image installs gssg"
require_text "$IMAGE_WORKFLOW" 'ghcr.io/.*/ghost-on-github-pages' "GHCR image name"
require_text "$IMAGE_WORKFLOW" ':exporter' "exporter tag"
if grep -Eq '^FROM[[:space:]]+ghost' "$DOCKERFILE"; then
	fail "exporter image must not be based on the official Ghost image"
else
	echo "[OK] exporter image does not retag ghost"
fi
require_text "${ROOT}/.github/workflows/ci.yml" '914e7df21a07ef503a81201c76d2b11c789d3fca' "actionlint installer is pinned"
require_text "${ROOT}/.github/workflows/ci.yml" '1\.7\.12' "actionlint version is pinned"
require_text "${ROOT}/scripts/compose-setup.sh" 'includes/lib/\.' "compose setup replaces lib contents"
require_text "${ROOT}/install.sh" 'includes/lib/\.' "install replaces lib contents"
require_text "${ROOT}/scripts/compose-smoke.sh" 'data/ghost\.db' "smoke test checks the SQLite file"

if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
	if docker compose -f "$COMPOSE" config >/dev/null; then
		echo "[OK] docker compose config"
	else
		fail "docker compose config failed"
	fi
else
	echo "[WARN] docker compose not available; skipped compose config"
fi

TMP_ROOT="$(mktemp -d)"
cleanup_tmp() {
	rm -rf "$TMP_ROOT"
}
trap cleanup_tmp EXIT

export GHOST_INSTALL="${TMP_ROOT}/.ghost"
export HOME="${TMP_ROOT}/home"
mkdir -p "$HOME"
if ! bash "${ROOT}/scripts/compose-setup.sh" >/dev/null; then
	fail "compose-setup.sh failed on the first run"
fi
if ! bash "${ROOT}/scripts/compose-setup.sh" >/dev/null; then
	fail "compose-setup.sh failed on the second run"
fi
if [ -f "${GHOST_INSTALL}/lib/lib/common.sh" ]; then
	fail "second compose-setup.sh nested lib/lib/common.sh"
elif [ ! -f "${GHOST_INSTALL}/lib/common.sh" ]; then
	fail "compose-setup.sh did not install lib/common.sh"
else
	echo "[OK] compose-setup.sh replaces lib on rerun"
fi

run_uninstall() {
	local docker_exit="$1"
	local case_dir="${TMP_ROOT}/uninstall-${docker_exit}"
	local bin="${case_dir}/bin"
	mkdir -p "$bin" "${case_dir}/.ghost"
	printf '%s\n' '#!/bin/sh' "exit ${docker_exit}" > "${bin}/docker"
	chmod +x "${bin}/docker"
	touch "${case_dir}/.ghost/.docker" "${case_dir}/.ghost/compose.yaml"
	set +e
	PATH="${bin}:${PATH}" GHOST_INSTALL="${case_dir}/.ghost" HOME="${case_dir}" \
		bash "${ROOT}/includes/uninstall.sh" >/tmp/gogp-uninstall.out 2>/tmp/gogp-uninstall.err <<< 'yes'
	local status=$?
	set -e
	UNINSTALL_STATUS=$status
	UNINSTALL_OUT="$(cat /tmp/gogp-uninstall.out /tmp/gogp-uninstall.err)"
}

run_uninstall 1
if [ "$UNINSTALL_STATUS" -eq 0 ] || ! grep -q "may still be running" <<<"$UNINSTALL_OUT"; then
	fail "uninstall reported success when docker compose down failed"
else
	echo "[OK] uninstall fails when Compose does not stop"
fi

run_uninstall 0
if [ "$UNINSTALL_STATUS" -ne 0 ] || ! grep -q "Docker Compose Ghost was stopped" <<<"$UNINSTALL_OUT"; then
	fail "uninstall did not report a stopped stack after docker compose down succeeded"
else
	echo "[OK] uninstall reports stopped only after Compose stops"
fi

if [ "$FAILED" -ne 0 ]; then
	echo "[ERROR] Compose / workflow tests failed." >&2
	exit 1
fi

echo "[OK] Compose and workflow fixture tests passed."
