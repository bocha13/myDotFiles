#!/bin/bash

sinks=($(pactl list short sinks | awk '{print $2}'))
current_sink=$(pactl info | grep "Default Sink" | cut -d' ' -f3)

for i in "${!sinks[@]}"; do
  if [[ "${sinks[i]}" == "$current_sink" ]]; then
    next_index=$(( (i + 1) % ${#sinks[@]} ))
    next_sink="${sinks[next_index]}"
    pactl set-default-sink "$next_sink"
    notify-send "Audio Output Switched" "Now using: $next_sink"
    break
  fi
done
