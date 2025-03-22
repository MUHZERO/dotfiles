#!/bin/bash

# Define the paths
theme_file="$HOME/.config/rofi/current_theme"
default_theme="$HOME/.config/rofi/launchers/type-1/style-1.rasi"
launchers_dir="$HOME/.config/rofi/launchers"

# Function to launch Rofi with the selected theme
launch_rofi() {
    theme=$(cat "$theme_file" 2>/dev/null || echo "$default_theme")
    pkill rofi || rofi -show drun -theme "$theme" -modi drun,filebrowser,run,window
}

# Function to switch Rofi theme
switch_theme() {
    theme=$(cat "$theme_file" 2>/dev/null || echo "$default_theme")
    selected_theme=$(find "$launchers_dir" -type f -name "*.rasi" | \
        sed "s|$launchers_dir/||" | \
        rofi -theme "$theme" -dmenu -p "Select Theme")

    if [[ -n "$selected_theme" ]]; then
        echo "$launchers_dir/$selected_theme" > "$theme_file"
    fi
}

# Check the argument to decide what to do
case "$1" in
    --launch)
        launch_rofi
        ;;
    --switch)
        switch_theme
        ;;
    *)
        echo "Usage: $0 {--launch|--switch}"
        exit 1
        ;;
esac
