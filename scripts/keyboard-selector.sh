#!/bin/bash

# Keyboard Layout Script Generator
# This script creates a custom keyboard layout switcher based on user input

echo "=== Keyboard Layout Script Generator ==="
echo "This will create a script to switch between keyboard layouts in Hyprland with Waybar"
echo

# Function to get flag emoji for a country code
get_flag_emoji() {
    local layout="$1"
    case "$layout" in
        "us") echo "🇺🇸" ;;
        "ru") echo "🇷🇺" ;;
        "de") echo "🇩🇪" ;;
        "fr") echo "🇫🇷" ;;
        "es") echo "🇪🇸" ;;
        "it") echo "🇮🇹" ;;
        "pt") echo "🇵🇹" ;;
        "br") echo "🇧🇷" ;;
        "jp") echo "🇯🇵" ;;
        "kr") echo "🇰🇷" ;;
        "cn") echo "🇨🇳" ;;
        "in") echo "🇮🇳" ;;
        "gb"|"uk") echo "🇬🇧" ;;
        "ca") echo "🇨🇦" ;;
        "au") echo "🇦🇺" ;;
        "mx") echo "🇲🇽" ;;
        "ar") echo "🇦🇷" ;;
        "pl") echo "🇵🇱" ;;
        "nl") echo "🇳🇱" ;;
        "se") echo "🇸🇪" ;;
        "no") echo "🇳🇴" ;;
        "dk") echo "🇩🇰" ;;
        "fi") echo "🇫🇮" ;;
        "cz") echo "🇨🇿" ;;
        "sk") echo "🇸🇰" ;;
        "hu") echo "🇭🇺" ;;
        "ro") echo "🇷🇴" ;;
        "bg") echo "🇧🇬" ;;
        "ua") echo "🇺🇦" ;;
        "tr") echo "🇹🇷" ;;
        "gr") echo "🇬🇷" ;;
        "il") echo "🇮🇱" ;;
        "sa") echo "🇸🇦" ;;
        "ae") echo "🇦🇪" ;;
        "th") echo "🇹🇭" ;;
        "vn") echo "🇻🇳" ;;
        "ph") echo "🇵🇭" ;;
        "id") echo "🇮🇩" ;;
        "my") echo "🇲🇾" ;;
        "sg") echo "🇸🇬" ;;
        *) echo "🌐" ;;  # Generic globe for unknown layouts
    esac
}

# Function to get language name for notification
get_language_name() {
    local layout="$1"
    case "$layout" in
        "us") echo "English" ;;
        "ru") echo "Русский" ;;
        "de") echo "Deutsch" ;;
        "fr") echo "Français" ;;
        "es") echo "Español" ;;
        "it") echo "Italiano" ;;
        "pt") echo "Português" ;;
        "br") echo "Português (Brasil)" ;;
        "jp") echo "日本語" ;;
        "kr") echo "한국어" ;;
        "cn") echo "中文" ;;
        "in") echo "हिन्दी" ;;
        "gb"|"uk") echo "English (UK)" ;;
        "ca") echo "English (Canada)" ;;
        "au") echo "English (Australia)" ;;
        "mx") echo "Español (México)" ;;
        "ar") echo "Español (Argentina)" ;;
        "pl") echo "Polski" ;;
        "nl") echo "Nederlands" ;;
        "se") echo "Svenska" ;;
        "no") echo "Norsk" ;;
        "dk") echo "Dansk" ;;
        "fi") echo "Suomi" ;;
        "cz") echo "Čeština" ;;
        "sk") echo "Slovenčina" ;;
        "hu") echo "Magyar" ;;
        "ro") echo "Română" ;;
        "bg") echo "Български" ;;
        "ua") echo "Українська" ;;
        "tr") echo "Türkçe" ;;
        "gr") echo "Ελληνικά" ;;
        "il") echo "עברית" ;;
        "sa") echo "العربية" ;;
        "ae") echo "العربية (UAE)" ;;
        "th") echo "ไทย" ;;
        "vn") echo "Tiếng Việt" ;;
        "ph") echo "Filipino" ;;
        "id") echo "Bahasa Indonesia" ;;
        "my") echo "Bahasa Malaysia" ;;
        "sg") echo "English (Singapore)" ;;
        *) echo "$layout" ;;
    esac
}

# Collect keyboard layouts from user
layouts=()
echo "Enter keyboard layouts (e.g., us, ru, de, fr, etc.):"
echo "Press Enter after each layout. Type 'done' when finished."
echo "Common layouts: us, ru, de, fr, es, it, pt, jp, kr, cn, gb, etc."
echo

while true; do
    read -p "Layout $(( ${#layouts[@]} + 1 )): " layout
    
    if [[ "$layout" == "done" ]]; then
        break
    elif [[ -z "$layout" ]]; then
        echo "Please enter a layout or 'done' to finish."
        continue
    else
        layouts+=("$layout")
        flag=$(get_flag_emoji "$layout")
        lang=$(get_language_name "$layout")
        echo "Added: $layout ($flag $lang)"
    fi
done

if [[ ${#layouts[@]} -lt 1 ]]; then
    echo "Error: You need at least 1 keyboard layout to create a switcher."
    exit 1
fi

# If only one layout is provided, duplicate it to make the switcher work
if [[ ${#layouts[@]} -eq 1 ]]; then
    layouts+=("${layouts[0]}")
    echo "Only one layout provided. Duplicating '${layouts[0]}' to ensure compatibility."
fi

echo
echo "Creating keyboard layout switcher script..."

# Set output filename
output_file="~/.config/gruvland/scripts/flag.sh"

# Generate the script
cat > "$output_file" << 'EOF'
#!/bin/bash
CONFIG=~/.dotfiles/waybar/config.jsonc

EOF

# Add the logic for each layout
for i in "${!layouts[@]}"; do
    current_layout="${layouts[$i]}"
    next_index=$(( (i + 1) % ${#layouts[@]} ))
    next_layout="${layouts[$next_index]}"
    
    current_flag=$(get_flag_emoji "$current_layout")
    next_flag=$(get_flag_emoji "$next_layout")
    next_lang=$(get_language_name "$next_layout")
    
    if [[ $i -eq 0 ]]; then
        echo "# Get the current flag from config.jsonc" >> "$output_file"
    fi
    
    if [[ $i -eq 0 ]]; then
        echo "if grep -q '$current_flag' \"\$CONFIG\"; then" >> "$output_file"
    else
        echo "elif grep -q '$current_flag' \"\$CONFIG\"; then" >> "$output_file"
    fi
    
    echo "    # $current_flag is currently set, switch to $next_flag" >> "$output_file"
    echo "    sed -i 's/$current_flag/$next_flag/' \"\$CONFIG\"" >> "$output_file"
    echo "    hyprctl keyword input:kb_layout $next_layout" >> "$output_file"
    echo "    notify-send \"$next_lang\"" >> "$output_file"
    echo "    echo \"Switched to $next_flag\"" >> "$output_file"
done

# Add the else clause and cleanup
cat >> "$output_file" << EOF
else
    echo "No known flag found in config.jsonc"
    # Set to first layout as default
    sed -i 's/🌐/$(get_flag_emoji "${layouts[0]}")/' "\$CONFIG"
    hyprctl keyword input:kb_layout ${layouts[0]}
    notify-send "$(get_language_name "${layouts[0]}")"
    echo "Set to default: $(get_flag_emoji "${layouts[0]}")"
fi

sleep 0.1
pkill -SIGUSR2 waybar
EOF

# Make the script executable
chmod +x "$output_file"

# Update hyprland.conf with the keyboard layouts
hyprland_conf="$HOME/.dotfiles/hyprland/hyprland.conf"
layouts_string=$(IFS=', '; echo "${layouts[*]}")

if [[ -f "$hyprland_conf" ]]; then
    # Replace line 26 with the new keyboard layouts
    sed -i "26s/.*/    kb_layout = $layouts_string/" "$hyprland_conf"
    echo "✅ Updated $hyprland_conf line 26 with: kb_layout = $layouts_string"
else
    echo "⚠️  Warning: $hyprland_conf not found. You'll need to manually add:"
    echo "    kb_layout = $layouts_string"
    echo "to your Hyprland config."
fi

echo "Configured layouts:"
for layout in "${layouts[@]}"; do
    flag=$(get_flag_emoji "$layout")
    lang=$(get_language_name "$layout")
    echo "  - $layout: $flag $lang"
done

