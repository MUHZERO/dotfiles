#!/bin/bash

# Path to the theme file
theme_file="$HOME/.config/rofi/current_theme"

# Check if the theme file exists and apply the theme
if [[ -f "$theme_file" ]]; then
    theme=$(cat "$theme_file")
     rofi -theme "$theme" "$@"
else
    rofi "$@"
fi
