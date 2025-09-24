#!/bin/bash

CONFIG=~/.dotfiles/waybar/config.jsonc
# Get the current flag from config.jsonc
if grep -q '🇷🇺' "$CONFIG"; then
    # 🇷🇺 is currently set, switch to 🇺🇸
    sed -i 's/🇷🇺/🇺🇸/' "$CONFIG"
    hyprctl keyword input:kb_layout us
    notify-send "English"
    echo "Switched to 🇺🇸"
elif grep -q '🇺🇸' "$CONFIG"; then
    # 🇺🇸 is currently set, switch to 🇷🇺
    sed -i 's/🇺🇸/🇷🇺/' "$CONFIG"
    hyprctl keyword input:kb_layout ru
    notify-send "Русский"
    echo "Switched to 🇷🇺"
else
    echo "No known flag found in config.jsonc"
fi
sleep 0.1
pkill -SIGUSR2 waybar
