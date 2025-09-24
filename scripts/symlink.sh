#!/usr/bin/env sh

home_dir="/home/$(whoami)"

# Fish
rm -r "$home_dir/.config/fish"; mkdir "$home_dir/.config/fish"
rm -r "$home_dir/.config/fish/functions"; mkdir "$home_dir/.config/fish/functions"
ln -s "$home_dir/.dotfiles/fish/config.fish" "$home_dir/.config/fish/config.fish"
ln -s "$home_dir/.dotfiles/fish/fish_variables" "$home_dir/.config/fish/fish_variables"
ln -s "$home_dir/.dotfiles/fish/functions/fish_prompt.fish" "$home_dir/.config/fish/functions/fish_prompt.fish"
ln -s "$home_dir/.dotfiles/fish/functions/fish_right_prompt.fish" "$home_dir/.config/fish/functions/fish_right_prompt.fish"

# Rofi
rm -r "$home_dir/.config/rofi"; mkdir "$home_dir/.config/rofi"
ln -s "$home_dir/.dotfiles/rofi/config.rasi" "$home_dir/.config/rofi/config.rasi"

# Hyprland
rm -r "$home_dir/.config/hypr"; mkdir "$home_dir/.config/hypr"
for file in env_var.conf hyprland.conf xdg-portal-hyprland hyprpaper.conf hypropacity; do
    ln -s "$home_dir/.dotfiles/hyprland/$file" "$home_dir/.config/hypr/$file"
done

# Waybar
rm -r "$home_dir/.config/waybar"; mkdir "$home_dir/.config/waybar"
rm -r "$home_dir/.config/scripts"; mkdir "$home_dir/.config/waybar/scripts"
ln -s "$home_dir/.dotfiles/waybar/config.jsonc" "$home_dir/.config/waybar/config.jsonc"
ln -s "$home_dir/.dotfiles/waybar/style.css" "$home_dir/.config/waybar/style.css"
ln -s "$home_dir/.dotfiles/waybar/colors.css" "$home_dir/.config/waybar/colors.css"
ln -s "$home_dir/.dotfiles/waybar/scripts/flag.sh" "$home_dir/.config/waybar/scripts/flag.sh"

# Kitty
rm -r "$home_dir/.config/kitty"; mkdir "$home_dir/.config/kitty"
for file in kitty.conf current-theme.conf; do
   ln -s "$home_dir/.dotfiles/kitty/$file" "$home_dir/.config/kitty/$file"
done

# Wlogout
rm -r "$home_dir/.config/wlogout"; mkdir "$home_dir/.config/wlogout"
ln -s "$home_dir/.dotfiles/wlogout/layout" "$home_dir/.config/wlogout/layout"

# Swaync
rm -r "$home_dir/.config/swaync"; mkdir "$home_dir/.config/swaync"
for file in config.json style.css widgets.css; do
   ln -s "$home_dir/.dotfiles/swaync/$file" "$home_dir/.config/swaync/$file"
done

# Swaylock
rm -r "$home_dir/.config/swaylock"; mkdir "$home_dir/.config/swaylock"
ln -s "$home_dir/.dotfiles/swaylock/config" "$home_dir/.config/swaylock/config"

# Gtk-3.0
rm -r "$home_dir/.config/gtk-3.0"; mkdir "$home_dir/.config/gtk-3.0"
for file in bookmarks settings.ini; do
   ln -s "$home_dir/.dotfiles/gtk-3.0/$file" "$home_dir/.config/gtk-3.0/$file"
done

rm -r "$home_dir/.themes"; mkdir "$home_dir/.themes"
rm -r "$home_dir/.icons"; mkdir "$home_dir/.icons"

for file in "$home_dir/.dotfiles/extras/gtk-3.0_extras/themes/"*; do
  if [[ -e "$file" ]]; then
    ln -s "$file" "$home_dir/.themes/$(basename "$file")"
  fi
done

for file in "$home_dir/.dotfiles/extras/gtk-3.0_extras/icons/"*; do
  if [[ -e "$file" ]]; then
    ln -s "$file" "$home_dir/.icons/$(basename "$file")"
  fi
done

# Fontconfig
rm -r "$home_dir/.config/fontconfig"; mkdir "$home_dir/.config/fontconfig"
ln -s "$home_dir/.dotfiles/fontconfig/fonts.conf" "$home_dir/.config/fontconfig/fonts.conf"
