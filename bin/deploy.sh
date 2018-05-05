#!/usr/bin/env bash

HOME_PATH=$HOME
GHOST_PATH="${HOME_PATH}/.ghost/"

first_deploy() {
	if [ -d "$GHOST_PATH" ]; then
		cd "$GHOST_PATH"

		# Setting up buster on the current folder.
		buster setup
		buster generate

		# Expects an input from user to provide a Git remote URL in which Ghost will be deployed.
		echo ' -------------------- INFORMATION NEEDED -------------------- '
		echo ''
		echo "Following you'll be asked to enter a Git Remote URL in which you would like to deploy Ghost."
		echo "Example:"
		echo "       git@github.com:YOUR_USERNAME/YOUR_REPOSITORY.git"
		echo ''
		read -p "Remote URL: "  remote_url

		git init
		git remote add origin "$remote_url"
		git add -A
		git commit -m "First commit on Github Pages using Ghost."
		git push origin master -f
		git push origin master:gh-pages
	fi
}

update() {
	if [ -d "$GHOST_PATH" ]; then
		cd "$GHOST_PATH"

		# Generating static files
		buster generate

		# Commiting changes to repository in order to deploy new content.
		git add -A
		git commit -m "Update on the website at $(date)"
		git push origin master
		git push origin master:gh-pages
	fi
}
		
deploy() {
	if [ -d "$GHOST_PATH" ]; then
		cd "$GHOST_PATH"

		# Check if repo already exists on current path
		repo_exists="$(git status)"
		if [[ $repo_exists = *"Not a git repository"* ]]; then
			first_deploy
		else
			update
		fi
	fi
}
deploy


