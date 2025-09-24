#!/bin/bash

color=$(hyprpicker 2>&1 | grep -v '\[ERR\] renderSurface: PBUFFER null' | tail -n1)

echo -n "$color" | wl-copy

notify-send "Copied color: $color"
