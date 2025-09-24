#!/bin/bash

# Run hyprpicker, filter out error lines, get only the color output line
color=$(hyprpicker 2>&1 | grep -v '\[ERR\] renderSurface: PBUFFER null' | tail -n1)

# Copy the color to clipboard using wl-copy (Wayland clipboard tool)
echo -n "$color" | wl-copy

# Optionally print confirmation
notify-send "Copied color: $color"
