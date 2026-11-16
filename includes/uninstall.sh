#!/usr/bin/env bash

set -euo pipefail

HOME_PATH="${HOME}"
GHOST_INSTALL="${GHOST_INSTALL:-${HOME_PATH}/.ghost}"

uninstall() {
	if [ ! -d "$GHOST_INSTALL" ]; then
		echo "[INFO] No blog folder found at ${GHOST_INSTALL}."
		exit 0
	fi

	echo "[WARN] This will remove Ghost and your local blog from ${GHOST_INSTALL}."
	read -r -p "Are you sure? Type yes to continue: " answer
	if [ "$answer" != "yes" ]; then
		echo "[INFO] Uninstall cancelled."
		exit 0
	fi

	if [ -f "${GHOST_INSTALL}/.docker" ]; then
		if ! command -v docker >/dev/null 2>&1; then
			echo "[WARN] Docker is not available. The Compose stack may still be running." >&2
			exit 1
		fi
		if [ ! -f "${GHOST_INSTALL}/compose.yaml" ]; then
			echo "[WARN] ${GHOST_INSTALL}/compose.yaml is missing. The Compose stack may still be running." >&2
			exit 1
		fi
		if ! (cd "$GHOST_INSTALL" && docker compose down); then
			echo "[WARN] Could not stop the Docker Compose stack. It may still be running." >&2
			exit 1
		fi
		echo "[INFO] Docker Compose Ghost was stopped. Your files are still in ${GHOST_INSTALL}."
		echo "[INFO] Delete that folder yourself if you want a full cleanup (includes posts and images)."
		exit 0
	fi

	cd "$GHOST_INSTALL" && ghost uninstall --no-prompt --force
	echo "[INFO] Ghost has been removed from your computer."
}

uninstall
