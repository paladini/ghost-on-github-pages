#!/bin/sh
# get_latest_release() {
#   curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
#     grep '"tag_name":' |                                            # Get tag line
#     sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
# }
GHOST_ZIP=includes/latest_ghost_release.zip

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

	# Installing Ghost-CLI.
	# npm i -g ghost-cli@latest
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
setup


