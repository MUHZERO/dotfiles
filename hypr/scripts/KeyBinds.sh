#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Searchable enabled keybinds using rofi

theme_file="$HOME/.config/rofi/current_theme"
default_theme="$HOME/.config/rofi/launchers/type-1/style-1.rasi"
theme=$(cat "$theme_file" 2>/dev/null || echo "$default_theme")


# Kill yad to not interfere with this binds
pkill yad || true

# Define the config files
KEYBINDS_CONF="$HOME/.config/hypr/configs/Keybinds.conf"
USER_KEYBINDS_CONF="$HOME/.config/hypr/UserConfigs/UserKeybinds.conf"
LAPTOP_CONF="$HOME/.config/hypr/UserConfigs/Laptop.conf"

# Combine the contents of the keybinds files and filter for keybinds
KEYBINDS=$(cat "$KEYBINDS_CONF" "$USER_KEYBINDS_CONF" | grep -E '^(bind|bindl|binde|bindm)')

# Check if Laptop.conf exists and add its keybinds if present
if [[ -f "$LAPTOP_CONF" ]]; then
    LAPTOP_BINDS=$(grep -E '^(bind|bindl|binde|bindm)' "$LAPTOP_CONF")
    KEYBINDS+=$'\n'"$LAPTOP_BINDS"
fi

# check for any keybinds to display
if [[ -z "$KEYBINDS" ]]; then
    echo "No keybinds found."
    exit 1
fi

# Use rofi to display the keybinds
echo "$KEYBINDS" | rofi -theme "$theme" -dmenu -i -p "Keybinds" -config ~/.config/rofi/config-keybinds.rasi
