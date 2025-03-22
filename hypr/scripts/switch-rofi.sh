#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Define base directory
rofi_base="$HOME/.config/rofi/launchers"
theme_file="$HOME/.config/rofi/current_theme"
default_theme="$HOME/.config/rofi/launchers/type-1/style-1.rasi"
theme=$(cat "$theme_file" 2>/dev/null || echo "$default_theme")

# Function to generate menu options
menu() {
    options=()
    for type in "$rofi_base"/*; do
        [[ -d "$type" ]] || continue  # Ensure it's a directory
        type_name=$(basename "$type")

        for style in "$type"/*.rasi; do
            [[ -f "$style" ]] || continue  # Ensure it's a file
            style_name=$(basename "$style" .rasi)

            options+=("$type_name/$style_name")
        done
    done
    printf '%s\n' "${options[@]}"
}

# Get selection from Rofi menu
selection=$(menu | rofi -theme "$theme" -dmenu -p "Select Rofi Type & Style")

# Apply the selection
if [[ -n "$selection" ]]; then
    type=$(dirname "$selection")
    style=$(basename "$selection")

    dir="$rofi_base/$type"
    theme="$style"

    # Save the selected theme
    echo "${dir}/${theme}.rasi" > "$theme_file"
    notify-send -u low -t 2000 "Rofi theme set to: $type/$style"
    # Run Rofi with selected theme
   # rofi -show drun -theme "$(cat "$theme_file")"
else
    echo "No selection made. Exiting..."
fi

