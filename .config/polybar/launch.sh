#!/usr/bin/env sh

## Add this to your wm startup file.

## get second monitor (if there is any)
MONITOR2="$(xrandr --listmonitors | grep "1:" | cut -d ' ' -f6)"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar main -c ~/.config/polybar/config.ini &

if [[ -n $MONITOR2 ]]; then
    MONITOR="$MONITOR2" polybar -c ~/.config/polybar/config.ini secondary &
fi