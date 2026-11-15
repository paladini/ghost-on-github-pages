#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE="${ROOT}/compose.yaml"
WORKFLOW="${ROOT}/.github/workflows/publish-static.yml"
EXAMPLE="${ROOT}/examples/github/publish-static.yml"
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

require_text "$COMPOSE" 'image:[[:space:]]*ghost:6' "official Ghost 6 image"
require_text "$COMPOSE" '\$\{GHOST_PORT:-2373\}:2368' "host port 2373 maps to 2368"
require_text "$COMPOSE" '/var/lib/ghost/content' "content volume mount"
require_text "$COMPOSE" 'NODE_ENV:[[:space:]]*development' "development / SQLite mode"
require_text "$WORKFLOW" 'workflow_call:' "reusable workflow_call trigger"
require_text "$WORKFLOW" 'actions/upload-pages-artifact@v3' "Pages artifact upload"
require_text "$WORKFLOW" 'actions/deploy-pages@v4' "Pages deploy"
require_text "$WORKFLOW" 'ghost-static-site-generator' "gssg in CI"
require_text "$EXAMPLE" 'uses:[[:space:]]*paladini/ghost-on-github-pages/.github/workflows/publish-static.yml@master' "example calls reusable workflow"

if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
	if docker compose -f "$COMPOSE" config >/dev/null; then
		echo "[OK] docker compose config"
	else
		fail "docker compose config failed"
	fi
else
	echo "[WARN] docker compose not available; skipped compose config"
fi

if [ "$FAILED" -ne 0 ]; then
	echo "[ERROR] Compose / workflow tests failed." >&2
	exit 1
fi

echo "[OK] Compose and workflow fixture tests passed."
