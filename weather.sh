#!/usr/bin/env bash

LAT="6.45"
LON="3.39"
URL="https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,wind_speed_10m"
LOG="$HOME/weather-notifier/weather.log"

if ! DATA=$(curl -s --fail --max-time 10 "$URL"); then
  echo "$(date): offline or API error" >> "$LOG"
  exit 1
fi

TEMP=$(echo "$DATA" | jq -r '.current.temperature_2m // empty')
WIND=$(echo "$DATA" | jq -r '.current.wind_speed_10m // empty')

if [ -z "$TEMP" ] || [ -z "$WIND" ]; then
  echo "$(date): bad data received" >> "$LOG"
  exit 1
fi

MESSAGE="Temp: ${TEMP} C, Wind: ${WIND} km/h"
echo "$(date): $MESSAGE" >> "$LOG"
termux-notification --title "Weather update" --content "$MESSAGE"
