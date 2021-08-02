#!/usr/bin/env bash

# Add this script to your wm startup file.

# Terminate already running bar instances
pgrep -x polybar && pkill -x polybar
#killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar -q main -c "~/.config/polybar/config.ini" &
