#!/bin/bash

CONFIG="$HOME/.config/gruvland/dotfiles/hyprland/hyprland.conf"

# Replace $mainMod
mainmod="SUPER"

# Parse binds with comments
grep "^bind" "$CONFIG" | while IFS= read -r line; do
    # Extract comment if present
    comment=$(echo "$line" | grep -o '#.*' | sed 's/^# *//')
    # Remove comment from main part
    core=$(echo "$line" | cut -d'#' -f1 | sed 's/^bind *= *//' | sed 's/,$//')

    # Split on commas
    IFS=',' read -r mod key action cmd <<< "$core"
    mod=$(echo "$mod" | sed "s/\$mainMod/$mainmod/")

    # Format the output
    if [[ -n "$comment" ]]; then
        printf "%-20s  %s\n" "$mod + $key" "$comment"
    else
        printf "%-20s  %s\n" "$mod + $key" "$action $cmd"
    fi
done | rofi -dmenu -i -p "Hotkey Helper"
