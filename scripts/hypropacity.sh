#!/bin/bash

# File to store the current state
STATE_FILE="$HOME/.dotfiles/hyprland/hypropacity"

# Check current state (default to "on" if file doesn't exist)
if [[ -f "$STATE_FILE" ]]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
else
    CURRENT_STATE="on"
fi

if [[ "$CURRENT_STATE" == "on" ]]; then
    # Turn opacity OFF (set to 1.0 = fully opaque)
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(zen-beta)$"
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(kitty)$"
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(pcmanfm)$"
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(VSCodium)$"
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(wofi)$"
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(emacs)$"
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(vesktop)$"

    echo "off" > "$STATE_FILE"
    notify-send "Opacity" "Transparency disabled" -t 2000
else
    # Turn opacity ON (restore original values)
    hyprctl keyword windowrulev2 "opacity 0.80 0.80,class:^(zen-beta)$"
    hyprctl keyword windowrulev2 "opacity 0.65 0.90,class:^(kitty)$"
    hyprctl keyword windowrulev2 "opacity 0.8 0.8,class:^(pcmanfm)$"
    hyprctl keyword windowrulev2 "opacity 0.8 0.8,class:^(VSCodium)$"
    hyprctl keyword windowrulev2 "opacity 0.8 0.6,class:^(wofi)$"
    hyprctl keyword windowrulev2 "opacity 0.8 0.8,class:^(emacs)$"
    hyprctl keyword windowrulev2 "opacity 0.8 0.8,class:^(vesktop)$"

    echo "on" > "$STATE_FILE"
    notify-send "Opacity" "Transparency enabled" -t 2000
fi
