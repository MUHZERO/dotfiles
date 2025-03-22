#!/bin/bash

# Default battery threshold (can be overridden with a command-line argument)
THRESHOLD=${1:-20}
BATTERY_PATH="/sys/class/power_supply/BAT0/capacity"
STATUS_PATH="/sys/class/power_supply/BAT0/status"
NOTIFICATION_SOUND="/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
COOLDOWN_PERIOD=30  # Cooldown period in seconds
LOG_FILE="/tmp/battery_alert.log"

# Logging function
log() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$LOG_FILE"
}

# Check if required files exist
if [[ ! -f "$BATTERY_PATH" || ! -f "$STATUS_PATH" ]]; then
    log "Error: Battery or status file not found. Check your system configuration."
    exit 1
fi

# Check if notify-send and paplay are available
if ! command -v notify-send >/dev/null 2>&1; then
    log "Error: notify-send is not installed. Please install libnotify."
    exit 1
fi

if ! command -v paplay >/dev/null 2>&1; then
    log "Error: paplay is not installed. Please install pulseaudio or pipewire."
    exit 1
fi

log "Battery alert script started. Threshold: ${THRESHOLD}%"

# Track the last notification time
LAST_NOTIFICATION_TIME=0

# Function to send notification and play sound
notify_low_battery() {
    local battery_level=$1
    local current_time=$(date +%s)
    log "Battery at ${battery_level}%! Plug in your charger."

    if (( current_time - LAST_NOTIFICATION_TIME >= COOLDOWN_PERIOD )); then
        notify-send "⚠️ Low Battery" "Battery at ${battery_level}%! Plug in your charger." -u critical
        paplay "$NOTIFICATION_SOUND"
        LAST_NOTIFICATION_TIME=$current_time
        log "Notification sent and sound played."
    else
        log "Notification cooldown active. Skipping notification."
    fi
}

# Main loop using polling
log "Starting polling loop to monitor battery changes..."
while true; do
    BATTERY=$(cat "$BATTERY_PATH")
    STATUS=$(cat "$STATUS_PATH")
    log "Battery: $BATTERY%, Status: $STATUS"

    if [[ "$BATTERY" -le "$THRESHOLD" && "$STATUS" == "Discharging" ]]; then
        notify_low_battery "$BATTERY"
    fi

    sleep 60  # Check every 60 seconds
done
