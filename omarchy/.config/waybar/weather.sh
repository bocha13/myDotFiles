#!/usr/bin/env bash

#  Put this on your waybar config.jsonc
#  then add "custom/weather" to any of the modules (modules-left, modules-right or modules-center)
#
#   "custom/weather": {
#     "exec": "~/.config/waybar/weather.sh",
#     "interval": 600, // refresh every 10 min
#     "return-type": "json",
#     "id": "custom-weather"
#   },

CITY="Santa%20Fe,AR"

ICON_SUN="☀️"
ICON_CLOUD="☁️"
ICON_RAIN="🌧️"
ICON_SNOW="❄️"
ICON_UNKNOWN="🌡️"

# Fetch weather JSON with proper headers
weather=$(curl -sf -A "curl" "https://wttr.in/${CITY}?format=j1")

if [ -n "$weather" ]; then
    # Current weather
    temp=$(echo "$weather" | jq -r ".current_condition[0].temp_C")
    condition=$(echo "$weather" | jq -r ".current_condition[0].weatherDesc[0].value")

    # Determine icon
    case $condition in
        Clear*|Sunny*) icon=$ICON_SUN ;;
        Cloud*|Overcast*) icon=$ICON_CLOUD ;;
        Rain*|Drizzle*) icon=$ICON_RAIN ;;
        Snow*) icon=$ICON_SNOW ;;
        *) icon=$ICON_UNKNOWN ;;
    esac

    # Build tooltip (3-day forecast)
    tooltip=""
    for i in {0..2}; do
        day=$(date -d "+$i day" +%a)
        day_temp=$(echo "$weather" | jq -r ".weather[$i].avgtempC")
        day_cond=$(echo "$weather" | jq -r ".weather[$i].hourly[0].weatherDesc[0].value")
        case $day_cond in
            Clear*|Sunny*) day_icon=$ICON_SUN ;;
            Cloud*|Overcast*) day_icon=$ICON_CLOUD ;;
            Rain*|Drizzle*) day_icon=$ICON_RAIN ;;
            Snow*) day_icon=$ICON_SNOW ;;
            *) day_icon=$ICON_UNKNOWN ;;
        esac
        tooltip+="$day $day_icon ${day_temp}°C\n"
    done

    # Output JSON for Waybar
    echo "{\"text\": \"\u2009\u2009 ${temp}°C $icon\", \"tooltip\": \"$tooltip\"}"
else
    echo "{\"text\": \"--\", \"tooltip\": \"No data\"}"
fi
