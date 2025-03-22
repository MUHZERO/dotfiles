#!/bin/bash

# List of keyboards
KEYBOARDS=("at-translated-set-2-keyboard" "telink-wireless-receiver")

# First, force a reset to Arabic
for keyboard in "${KEYBOARDS[@]}"; do
    hyprctl switchxkblayout "$keyboard" "ara" >/dev/null 2>&1
done

# Wait a bit to ensure the change is applied
sleep 0.2

# Now, switch to the next layout
for keyboard in "${KEYBOARDS[@]}"; do
    hyprctl switchxkblayout "$keyboard" next >/dev/null 2>&1
done

# Get the new layout and show notification
current_layout=$(hyprctl devices | grep -A 10 "at-translated-set-2-keyboard" | grep "active keymap" | awk '{print $3}')
notify-send -u low -t 2000 "Keyboard Layout Changed" "New Layout: $current_layout"

