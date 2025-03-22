#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Clipboard Manager. This script uses cliphist, rofi, and wl-copy.

# Actions:
# CTRL Del to delete an entry
# ALT Del to wipe clipboard contents
theme_file="$HOME/.config/rofi/current_theme"
default_theme="$HOME/.config/rofi/launchers/type-1/style-1.rasi"
theme=$(cat "$theme_file" 2>/dev/null || echo "$default_theme")


while true; do
    result=$(
        rofi -i -theme "$theme" -dmenu \
            -kb-custom-1 "Control-Delete" \
            -kb-custom-2 "Alt-Delete" \
            -config ~/.config/rofi/config-clipboard.rasi < <(cliphist list)
    )

    case "$?" in
        1)
            exit
            ;;
        0)
            case "$result" in
                "")
                    continue
                    ;;
                *)
                    cliphist decode <<<"$result" | wl-copy
                    exit
                    ;;
            esac
            ;;
        10)
            cliphist delete <<<"$result"
            ;;
        11)
            cliphist wipe
            ;;
    esac
done

