#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"${ROOT}/scripts/validate-static.sh" "${ROOT}/tests/fixtures/good"

if "${ROOT}/scripts/validate-static.sh" "${ROOT}/tests/fixtures/bad-localhost" 2>/dev/null; then
	echo "[ERROR] bad-localhost fixture should have failed validation" >&2
	exit 1
fi

if "${ROOT}/scripts/validate-static.sh" "${ROOT}/tests/fixtures/bad-srcset" 2>/dev/null; then
	echo "[ERROR] bad-srcset fixture should have failed validation" >&2
	exit 1
fi

echo "[OK] Validation fixture tests passed."
