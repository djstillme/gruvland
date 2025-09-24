#!/bin/bash

# Script to toggle Hyprland's "clean" submap mode
# Save this as ~/.config/hypr/scripts/toggle_clean_mode.sh
# Make it executable with: chmod +x ~/.config/hypr/scripts/toggle_clean_mode.sh

# Create log directory if it doesn't exist
LOGDIR="$HOME/.config/hypr/logs"
mkdir -p "$LOGDIR"

# Get current submap and log it
CURRENT_SUBMAP=$(hyprctl getoption submap -j | jq -r .str)
echo "$(date): Current submap is '$CURRENT_SUBMAP'" >> "$LOGDIR/submap_toggle.log"

# Try a different approach - use a state file to track the toggle state
STATE_FILE="$HOME/.config/hypr/clean_mode_active"

if [ -f "$STATE_FILE" ]; then
    # File exists, clean mode is active, turn it off
    rm "$STATE_FILE"
    hyprctl dispatch submap reset
    echo "$(date): Disabling clean mode" >> "$LOGDIR/submap_toggle.log"
    notify-send "Hyprland" "Global Hotkeys Enabled" -t 2000
else
    # File doesn't exist, clean mode is inactive, turn it on
    touch "$STATE_FILE"
    hyprctl dispatch submap clean
    echo "$(date): Enabling clean mode" >> "$LOGDIR/submap_toggle.log"
    notify-send "Hyprland" "Global Hotkeys Disabled" -t 2000
fi
