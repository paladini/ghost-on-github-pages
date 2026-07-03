#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../includes/lib/common.sh
source "${SCRIPT_DIR}/../includes/lib/common.sh"

if [ ! -d "$GHOST_INSTALL" ]; then
	die "No blog folder found at ${GHOST_INSTALL}. Nothing to migrate."
fi

if ! ghost_current_ready; then
	die "Ghost does not look installed correctly in ${GHOST_INSTALL}. See docs/TROUBLESHOOTING.md"
fi

if command -v gssg >/dev/null 2>&1 && [ -f "${GHOST_INSTALL}/lib/common.sh" ]; then
	die "This setup already looks like v3. No migration needed."
fi

if command -v buster >/dev/null 2>&1 || grep -q "buster" "${GHOST_INSTALL}/deploy.sh" 2>/dev/null; then
	info "Classic (v2) setup detected. Ready to migrate."
else
	warn "Could not confirm a Classic setup, but migration can still be attempted."
fi

cd "$GHOST_INSTALL" || die "Could not open ${GHOST_INSTALL}"
if ! ghost status 2>/dev/null | grep -q "running"; then
	warn "Your local blog does not appear to be running."
	warn "Start it with: cd ~/.ghost && ghost start"
fi

info "Pre-check passed."
