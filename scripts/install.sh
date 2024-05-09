#!/bin/bash

#!/bin/bash

# Define colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Print introduction message
echo -e "${GREEN}======================================${NC}"
echo -e "${CYAN} Welcome to toolchain installation script! ${NC}"
echo -e "${GREEN}======================================${NC}"


# Define GitHub repository owner and name
owner="raleksan"
repo="sna_project"

# Fetch information about the latest release using GitHub API
release_info=$(curl -s "https://api.github.com/repos/$owner/$repo/releases/latest")

# Extract download URL of the latest release asset
download_url=$(echo "$release_info" | jq -r '.assets[0].browser_download_url')

# Extract filename of the release asset
filename=$(echo "$release_info" | jq -r '.assets[0].name')

# Download the release asset
echo "Downloading latest release: $filename"
curl -LO "$download_url"

echo "Download complete: $filename"

# Unpack the actual_binary.tar.gz archive into the actual_binary directory
echo "Unpacking $filename into actual_binary directory"
mkdir actual_binary
tar -xzf "$filename" -C actual_binary
echo "Unpacking complete"