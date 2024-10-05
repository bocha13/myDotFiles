#!/bin/bash
# Script to show volume notification

# Get the current mute status and volume level
mute_status=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o "yes")
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)

# Check if muted and show the correct notification
if [ "$mute_status" == "yes" ]; then
    dunstify -t 1000 -r 2593 -u low "Volume: Muted"
else
    dunstify -t 1000 -r 2593 -u low "Volume: $volume"
fi
