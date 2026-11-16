#!/usr/bin/env bash
# Validate compose.yaml and optionally start Ghost long enough to prove it responds.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="${ROOT}/compose.yaml"
START_GHOST="${COMPOSE_SMOKE_START:-0}"

if [ "${1:-}" = "--start" ]; then
	START_GHOST=1
fi

if ! command -v docker >/dev/null 2>&1; then
	echo "[WARN] docker is not installed; skipping compose smoke."
	exit 0
fi

if ! docker compose version >/dev/null 2>&1; then
	echo "[WARN] docker compose is not available; skipping compose smoke."
	exit 0
fi

export GHOST_PORT="${GHOST_PORT:-2373}"
export GHOST_URL="${GHOST_URL:-http://localhost:${GHOST_PORT}}"
export GHOST_CONTENT="${GHOST_CONTENT:-${ROOT}/.tmp-ghost-content}"
mkdir -p "$GHOST_CONTENT"

echo "[INFO] Validating ${COMPOSE_FILE}..."
docker compose -f "$COMPOSE_FILE" config >/dev/null
echo "[OK] compose.yaml is valid."

if [ "$START_GHOST" != "1" ]; then
	exit 0
fi

cleanup() {
	docker compose -f "$COMPOSE_FILE" down --remove-orphans >/dev/null 2>&1 || true
}
trap cleanup EXIT

echo "[INFO] Starting Ghost (this downloads ghost:6 on first run)..."
docker compose -f "$COMPOSE_FILE" up -d

# shellcheck source=includes/lib/common.sh
source "${ROOT}/includes/lib/common.sh"
GHOST_SERVER_URL="http://localhost:${GHOST_PORT}"

if ! wait_for_ghost_http 45; then
	docker compose -f "$COMPOSE_FILE" logs ghost >&2 || true
	echo "[ERROR] Ghost did not become ready at ${GHOST_SERVER_URL}" >&2
	exit 1
fi

DB_FILE="${GHOST_CONTENT}/data/ghost.db"
if [ ! -f "$DB_FILE" ]; then
	docker compose -f "$COMPOSE_FILE" logs ghost >&2 || true
	echo "[ERROR] SQLite database was not written to ${DB_FILE}" >&2
	echo "[ERROR] Posts would be lost when the container is removed." >&2
	exit 1
fi

echo "[OK] Ghost responded at ${GHOST_SERVER_URL}"
echo "[OK] SQLite database is at ${DB_FILE}"
