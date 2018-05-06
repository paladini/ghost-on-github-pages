#!/usr/bin/env bash
HOME_PATH=$HOME
GHOST_PATH="${HOME_PATH}/.ghost/"

uninstall() {
	if [ -d "$GHOST_PATH" ]; then
		(cd "$GHOST_PATH" && ghost uninstall --no-prompt --force)
	fi
}
uninstall