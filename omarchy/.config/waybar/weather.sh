#!/usr/bin/env bash
set -euo pipefail

# WARN: DON'T FORGET TO SET OWM_API_KEY ON YOUR ENV!!!
# WARN: you need to add the variable to the /etc/environment file
# WARN: because waybar loads before bashrc is called
#
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
UNIT="metric"
API_KEY="${OWM_API_KEY:-}"

# Wait for network (max 30 seconds)
for i in {1..30}; do
  if ping -c1 8.8.8.8 &>/dev/null; then break; fi
  sleep 1
done

# Icons
ICON_SUN="☀️"
ICON_MOON="🌙"
ICON_CLOUD="☁️"
ICON_RAIN="🌧️"
ICON_SNOW="❄️"
ICON_UNKNOWN="🌡️"

if [ -z "$API_KEY" ]; then
  echo '{"text":"--"}'
  exit 0
fi

url="https://api.openweathermap.org/data/2.5/weather?q=$CITY&units=$UNIT&appid=$API_KEY"
resp=$(curl -s "$url")

# Make sure we got a valid response
if ! echo "$resp" | grep -q '"cod":200'; then
  echo '{"text":"--"}'
  exit 0
fi

temp=$(echo "$resp" | sed -n 's/.*"temp":\([^,}]*\).*/\1/p' | head -1 | cut -d. -f1)
condition=$(echo "$resp" | sed -n 's/.*"main":"\([^"]*\)".*/\1/p' | head -1)
icon_code=$(echo "$resp" | sed -n 's/.*"icon":"\([^"]*\)".*/\1/p' | head -1)

# Unit symbol
case "$UNIT" in
  metric) unit="°C" ;;
  imperial) unit="°F" ;;
  *) unit="K" ;;
esac

# Determine day/night
if [[ "$icon_code" =~ n$ ]]; then
  is_night=1
else
  is_night=0
fi

# Pick icon
case "$condition" in
  Clear)
    if [ "$is_night" -eq 1 ]; then
      icon="$ICON_MOON"
    else
      icon="$ICON_SUN"
    fi
    ;;
  Clouds) icon="$ICON_CLOUD" ;;
  Rain|Drizzle|Thunderstorm) icon="$ICON_RAIN" ;;
  Snow) icon="$ICON_SNOW" ;;
  *) icon="$ICON_UNKNOWN" ;;
esac

# Waybar JSON output
echo "{\"text\":\"  ${temp}${unit} ${icon}\"}"
