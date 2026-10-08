#!/usr/bin/env bash

LAT="6.45"
LON="3.39"
URL="https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,wind_speed_10m"

DATA=$(curl -s "$URL")
TEMP=$(echo "$DATA" | jq '.current.temperature_2m')
WIND=$(echo "$DATA" | jq '.current.wind_speed_10m')

MESSAGE="Temp: ${TEMP} C, Wind: ${WIND} km/h"
echo "$MESSAGE"

termux-notification --title "Weather update" --content "$MESSAGE"
