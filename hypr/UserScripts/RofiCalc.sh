#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */
# /* Calculator (using qalculate) and rofi */
# /* Submitted by: https://github.com/JosephArmas */

rofi_config="$HOME/.config/rofi/config-calc.rasi"
theme_file="$HOME/.config/rofi/current_theme"
default_theme="$HOME/.config/rofi/launchers/type-1/style-1.rasi"
theme=$(cat "$theme_file" 2>/dev/null || echo "$default_theme")

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

# main function

while true; do
    result=$(
        rofi -i -theme "$theme" -dmenu \
            -config "$rofi_config" \
            -mesg "$result      =    $calc_result"
    )

    if [ $? -ne 0 ]; then
        exit
    fi

    if [ -n "$result" ]; then
        calc_result=$(qalc -t "$result")
        echo "$calc_result" | wl-copy
    fi
done
