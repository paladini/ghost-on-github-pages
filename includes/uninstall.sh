#!/usr/bin/env bash

set -euo pipefail

HOME_PATH="${HOME}"
GHOST_INSTALL="${HOME_PATH}/.ghost"

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

	cd "$GHOST_INSTALL" && ghost uninstall --no-prompt --force
	echo "[INFO] Ghost has been removed from your computer."
}

uninstall
