#!/bin/sh
# get_latest_release() {
#   curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
#     grep '"tag_name":' |                                            # Get tag line
#     sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
# }

# Download latest Ghost release
# curl -s https://api.github.com/repos/TryGhost/Ghost/releases/latest | jq --raw-output '.assets[0] | .browser_download_url'
LATEST_GHOST=$(curl -s https://api.github.com/repos/TryGhost/Ghost/releases/latest | grep browser_download_url | cut -d '"' -f 4)
curl -L0 $LATEST_GHOST -o latest_ghost_release.zip
# echo $LATEST_GHOST
