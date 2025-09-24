#!/bin/bash

# Define color codes
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
RESET='\033[0m'

# Function to display disk usage
check_disk_space() {
    echo -e "${YELLOW}Current disk usage:${RESET}"
    df -h --total | grep 'total'
}

# Initial Message
echo -e "${GREEN}~Lets clean things up!~${RESET}"

sleep 3

# Check disk space before running commands
echo -e "${YELLOW}Checking disk space before maintenance...${RESET}"
check_disk_space
initial_space=$(df --total | awk '/total/ {print $3}')

# System Maintenance Commands
echo -e "${YELLOW}Updating mirrorlist...${RESET}"
sudo reflector --verbose --latest 5 --download-timeout 60 --country 'United States' --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo -e "${YELLOW}Updating system packages...${RESET}"
sudo pacman -Syu

# echo -e "${YELLOW}Updating Conda...${RESET}"
# conda update -n base conda

echo -e "${YELLOW}Updating AUR packages with paru...${RESET}"
paru -Syu

# echo -e "${YELLOW}Updating Emacs repository...${RESET}"
# git -C ~/git/public/emacs-30/ pull

# Cleanup Commands
echo -e "${YELLOW}Removing unused packages...${RESET}"
sudo pacman -Qtdq | sudo pacman -Rncs -

echo -e "${YELLOW}Clearing package cache...${RESET}"
sudo pacman -Scc --noconfirm

echo -e "${YELLOW}Clearing /.cache...${RESET}"
sudo rm -rvf ~/.cache

echo -e "${YELLOW}Clearing trash bin...${RESET}"
gio trash --empty

# Check disk space after running commands
echo -e "${YELLOW}Checking disk space after maintenance...${RESET}"
check_disk_space
final_space=$(df --total | awk '/total/ {print $3}')

# Calculate space gained or lost
space_diff=$((final_space - initial_space))
if [ "$space_diff" -gt 0 ]; then
    echo -e "${RED} Gained: $((space_diff / 1024)) MB${RESET}"
else
    echo -e "${RED} Removed: $(( -space_diff / 1024 )) MB${RESET}"
fi

echo -e "${GREEN}Script completed successfully!${RESET}"

sleep 5
