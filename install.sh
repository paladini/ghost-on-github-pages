#!/bin/sh
GHOST_ZIP=includes/latest_ghost_release.zip
HOME_PATH=$HOME
GHOST_PATH="${HOME_PATH}/.ghost/"

check_ghost_folder() {
	if [ ! -d "includes/ghost" ]; then
		echo '[ERROR] Ghost not found at includes/ghost!!! Exiting...'
		exit
	fi
}

# Download latest Ghost release using CURL.
ghost_download_latest() {
	if [ ! -f "$GHOST_ZIP" ]; then
		echo 'Downloading latest Ghost release...'
		LATEST_GHOST=$(curl -s https://api.github.com/repos/TryGhost/Ghost/releases/latest | grep browser_download_url | cut -d '"' -f 4)
		mkdir -p includes
		curl -L0 $LATEST_GHOST -o $GHOST_ZIP
		echo 'Finished! File located at [${GHOST_ZIP}]'
	else
		echo 'Latest Ghost release already downloaded!'
	fi
}

ghost_extract_and_install() {

	# Download and extract current Ghost release.
	if [ -d "includes/ghost" ]; then
		echo 'Ghost already extracted. Removing it since it could be an older version.'
		# rm -rf includes/ghost
	fi
	
	if [ ! -d "includes/ghost" ]; then
		echo 'Extracting [${GHOST_ZIP}] into [includes/ghost/] folder.'
		mkdir -p includes/ghost
		unzip $GHOST_ZIP -d includes/ghost/
	fi
}

ghost_install_deps() {
	check_ghost_folder
	echo ''
	echo '--------------------------------'
	echo ''
	echo '    Installing dependencies...'
	echo ''
	echo '--------------------------------'
	echo ''
	(cd includes/ghost && npm install && npm install knex-migrator)
}

ghost_start() {
	check_ghost_folder
	echo ''
	echo '--------------------------------'
	echo ''
	echo '    Starting Ghost server...'
	echo ''
	echo '--------------------------------'
	echo ''
	(cd includes/ghost && knex-migrator init && npm start)
}

setup() {
	echo '[ 0% ]'
	ghost_download_latest
	echo '[ 40% ]'
	ghost_extract_and_install
	echo '[ 70% ]'
	ghost_install_deps
	echo '[ 90% ]'
	ghost_start
	echo '[ 100% ]'
}

local_setup() {
	if [ -d "$GHOST_PATH" ]; then
		echo '[INFO] Ghost already installed at' "$GHOST_PATH"
	else
		echo '[INFO] Installing Ghost-CLI...'
		mkdir -p "$GHOST_PATH"
		cd "$GHOST_PATH"
	
		# Installing Ghost CLI
		npm i -g ghost-cli@latest

		# Installing local version of Ghost
		echo '[INFO] Trying to install Ghost using Ghost-CLI...'
		echo '[INFO] Installing Ghost at' "$GHOST_PATH"
		ghost install local --no-start
	fi
	# echo '[INFO] Finished!'
}

local_deps() {
	cd "$GHOST_PATH"
	check_pip=$(which pip)
	check_pip2=$(which pip2)

	if [ "$check_pip" ]; then
		pip install buster
	else
		echo "Python package manager (pip) was not found. Trying 'pip2' instead."

		if [ "$check_pip2" ]; then
			pip2 install buster
		else
			echo "Any Python package manager was found, please install 'pip' for Python and try again."
			exit
		fi
	fi
}

local_run() {
	if [ -d "$GHOST_PATH" ]; then
		# echo '[INFO] Ghost found at' "$GHOST_PATH"
		echo '[INFO] Starting Ghost server...'
		cd "$GHOST_PATH"
		ghost start
	fi
	# else
	# 	echo '[INFO] Installing Ghost-CLI...'
	# 	mkdir -p "$GHOST_PATH"
	# 	cd $GHOST_PATH
	
	# 	# Installing Ghost CLI
	# 	npm i -g ghost-cli@latest

	# 	# Installing local version of Ghost
	# 	echo '[INFO] Installing Ghost using Ghost-CLI...'
	# 	echo 'Installation folder: $GHOST_PATH'
	# 	ghost install local --no-start
	# fi
	# echo '[INFO] Ghost server s!'
}

local_setup
local_deps
local_run

