#!/bin/bash

CONFIG="$HOME/.config/gruvland/dotfiles/hyprland/hyprland.conf"

mainmod="SUPER"

grep "^bind" "$CONFIG" | while IFS= read -r line; do

    comment=$(echo "$line" | grep -o '#.*' | sed 's/^# *//')
    
    core=$(echo "$line" | cut -d'#' -f1 | sed 's/^bind *= *//' | sed 's/,$//')

    IFS=',' read -r mod key action cmd <<< "$core"
    mod=$(echo "$mod" | sed "s/\$mainMod/$mainmod/")

    if [[ -n "$comment" ]]; then
        printf "%-20s  %s\n" "$mod + $key" "$comment"
    else
        printf "%-20s  %s\n" "$mod + $key" "$action $cmd"
    fi
done | rofi -dmenu -i -p "Hotkey Helper"
