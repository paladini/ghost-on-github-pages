#!/usr/bin/env bash
RELATIVE_PATH=$(dirname "$0")
GHOST_ZIP=includes/latest_ghost_release.zip
HOME_PATH=$HOME
GHOST_PATH="${HOME_PATH}/.ghost/"

# Operating system specific instructions
if [ "$(uname -s)" = 'Linux' ]; then
	CURRENT_SCRIPT_PATH=$(readlink -f "$0")
else
	CURRENT_SCRIPT_PATH=$(readlink "$0")
fi
CURRENT_FOLDER_PATH=$(dirname "$CURRENT_SCRIPT_PATH")

check_ghost_folder() {
	if [ ! -d "includes/ghost" ]; then
		echo '[ERROR] Ghost not found at includes/ghost!!! Exiting...'
		exit
	fi
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
		ghost install local --no-start --enable
	fi
	# echo '[INFO] Finished!'
}

move_includes() {
	if [ ! -d "includes/" ]; then
		cd "$RELATIVE_PATH"
	fi
	$(cp includes/deploy.sh "$GHOST_PATH/")
	$(cp includes/deploy.sh "$GHOST_PATH""/current/")
	$(cp includes/index.html "$GHOST_PATH""/current/")
	$(cp includes/gitignore.base "$GHOST_PATH""/current/")
	$(cp includes/gitignore.base "$GHOST_PATH""/current/.gitignore")
	$(chmod +x "$GHOST_PATH""/deploy.sh")
}

local_deps() {
	echo '[INFO] Installing needed dependencies...'

	cd "$GHOST_PATH"
	success=0
	check_pip=$(which pip)
	check_pip2=$(which pip2)
	check_pip27=$(which pip2.7)

	if [ "$check_pip" ]; then
		pip install buster
		success=`expr $success + 1`
	else
		echo "[INFO] Command 'pip' was not found on path..."
	fi

	if [ "$check_pip2" ]; then
		pip2 install buster
		success=`expr $success + 1`
	else
		echo "[INFO] Command 'pip2' was not found on path..."	
	fi

	if [ "$check_pip27" ]; then
		pip2.7 install buster
		success=`expr $success + 1`
	else
		echo "[INFO] Command 'pip2.7' was not found on path..."	
	fi

	# Checking if pip was found and 'buster' was successfully installed.
	if [ "$success" -eq "0" ]; then
		echo "[WARN] Command pip cannot be found on your system."
		echo "[WARN] Trying to install pip for Python 2..."

		# Trying to install pip for different OSs (MacOS and Linux)
		if [ "$(uname)" == "Darwin" ]; then
			echo '[INFO] Mac OS detected.'
			sudo easy_install pip
			sudo pip install --upgrade virtualenv
			sudo pip install buster
		elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
			echo '[INFO] Linux detected.'
			sudo apt-get install python-setuptools python-dev build-essential 
			sudo easy_install pip
			sudo pip install --upgrade virtualenv
			sudo pip install buster
		else
			echo '[ERROR] Operating System not supported yet. Please, open a Github Issue at https://github.com/paladini/ghost-on-github-pages/issues telling about this problem.'
			echo "[ERROR] Since 'pip' for Python 2 and 'buster' was not found and cannot be installed, I'm exiting this installation script now."
			exit
		fi
	fi
	
	# echo '[INFO] pip and Buster packages were successfully installed.'
	echo '[INFO] Done! Dependencies appears to be okay.'
}

local_run() {
	if [ -d "$GHOST_PATH" ]; then
		echo '[INFO] Starting Ghost server...'
		cd "$GHOST_PATH"
		ghost start --enable
	fi
}

local_setup
local_deps
local_run
move_includes

(cd "$GHOST_PATH" && ./deploy.sh)
