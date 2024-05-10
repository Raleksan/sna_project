#!/bin/bash

# Function to check if script is running with sudo privileges
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo "This script requires sudo privileges to run."
        echo "Requesting sudo rights..."
        if sudo -v; then
            echo "Sudo rights granted."
        else
            echo "Sudo rights denied. Exiting."
            exit 1
        fi
    fi
}

# Function to print introduction message
print_intro() {
    echo -e "${GREEN}======================================${NC}"
    echo -e "${CYAN} Welcome to toolchain installation script! ${NC}"
    echo -e "${GREEN}======================================${NC}"
}

# Function to fetch information about the latest release
fetch_latest_release() {
    owner="raleksan"
    repo="sna_project"
    release_info=$(curl -s "https://api.github.com/repos/$owner/$repo/releases/latest")
}

# Function to extract download URL of the latest release asset
extract_download_url() {
    download_url=$(echo "$release_info" | jq -r '.assets[0].browser_download_url')
}

# Function to extract filename of the release asset
extract_filename() {
    filename=$(echo "$release_info" | jq -r '.assets[0].name')
}

# Function to download the release asset
download_release_asset() {
    echo "Downloading latest release: $filename"
    curl -LO "$download_url"
    echo "Download complete: $filename"
}

# Function to unpack the release asset
unpack_release_asset() {
    echo "Unpacking $filename into actual_binary directory"
    mkdir actual_binary
    tar -xzf "$filename" -C actual_binary
    echo "Unpacking complete"
}

# Function to copy binary files to /usr/local/bin
copy_binary_files() {
    echo "Copying binary files to /usr/local/bin"
    sudo cp actual_binary/svls/* /usr/local/bin/
    sudo cp actual_binary/slang/* /usr/local/bin/
    echo "Copying complete"
}

# Function to remove temporary files
remove_temp_files() {
    echo "Removing temporary files"
    rm "$filename"
    rm -rf actual_binary
    echo "Removal complete"
}

copy_script() {
    echo "Copying script to /usr/local/sbin/"
    sudo cp "$0" /usr/local/sbin/
    echo "Copy complete"
}

# Function to create a weekly cron job if it doesn't exist
create_cron_job() {
    if ! crontab -l | grep -q "/usr/local/sbin/$(basename "$0")"; then
        
        # Copy script for cron job 
        copy_script
        
        # Add a cron job to run the script once a week
        (crontab -l ; echo "0 0 * * 0 /usr/local/sbin/$(basename "$0")") | crontab -
        echo "Cron job created to run the script once a week."
    else
        echo "Cron job already exists."
    fi
}

# Main function
main() {
    check_sudo
    print_intro
    fetch_latest_release
    extract_download_url
    extract_filename
    download_release_asset
    unpack_release_asset
    copy_binary_files
    remove_temp_files
    create_cron_job
}

# Call the main function
main
