#!/usr/bin/env sh

# Get dimensions of monitor
######################################
WIDTH=$(xrandr --current | grep '*' | awk '{print $1}' | cut -d 'x' -f1)
HEIGHT=$(xrandr --current | grep '*' | awk '{print $1}' | cut -d 'x' -f2)
HALF_WIDTH=$((WIDTH / 2))
HALF_HEIGHT=$((HEIGHT / 2))
######################################

# Apply dimensions to swaylock
######################################
SWAYLOCK_CONFIG="$HOME/.dotfiles/swaylock/config"
sed -i "s/^indicator-x-position=.*/indicator-x-position=$HALF_WIDTH/" "$SWAYLOCK_CONFIG"
sed -i "s/^indicator-y-position=.*/indicator-y-position=$HALF_HEIGHT/" "$SWAYLOCK_CONFIG"
######################################

# Apply monitor name to hyprpaper
######################################
HYPRPAPER_CONFIG="$HOME/.dotfiles/hyprland/hyprpaper.conf"
sed -i "s/MONITOR/$monitor/g" "$HYPRPAPER_CONFIG"
######################################
