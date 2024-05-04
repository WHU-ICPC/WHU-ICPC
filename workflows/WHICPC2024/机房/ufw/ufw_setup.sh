#!/bin/bash

# Set the list of IPv4 addresses to be allowed
allowed_ips=("8.8.8.8" "8.8.4.4" "202.114.96.1" "10.199.1.1" "43.142.113.15" "81.68.150.154" "1.15.236.237" "150.158.179.122" "81.69.177.93")

# Enable ufw
enable_ufw() {
    echo "Enabling ufw..."
    sudo ufw --force reset
    sudo ufw enable
}

# Disable ufw
disable_ufw() {
    echo "Disabling ufw..."
    sudo ufw disable
}

# Set default ufw rules
set_default_rules() {
    echo "Setting default ufw rules..."
    sudo ufw default deny incoming
    sudo ufw default deny outgoing
}

# Allow traffic on loopback interface
allow_loopback() {
    echo "Allowing loopback traffic..."
    sudo ufw allow in on lo
    sudo ufw allow out on lo
}

# Allow specific IPv4 addresses
allow_specific_ips() {
    echo "Allowing specific IPv4 addresses..."
    for ip in "${allowed_ips[@]}"
    do
        sudo ufw allow out to "$ip"
    done
}

# Check if running as root
check_root() {
    if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root" 1>&2
        exit 1
    fi
}

# Main menu
main_menu() {
    echo "------------------------------------"
    echo "1. Enable ufw"
    echo "2. Disable ufw"
    echo "3. Exit"
    echo "------------------------------------"
    read -p "Enter your choice: " choice
    case $choice in
        1) check_root; enable_ufw; set_default_rules; allow_specific_ips; allow_loopback; sudo ufw status verbose;;
        2) check_root; disable_ufw;;
        3) exit;;
        *) echo "Invalid choice";;
    esac
}

# Main program
main_menu

