#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        # (MONITOR=$m polybar -q b3 -c $HOME/.config/i3/polybar/polybar.ini)&
        (MONITOR=$m polybar -q b1 -c $HOME/.config/i3/polybar/polybar.ini)&
        (MONITOR=$m polybar -q b2 -c $HOME/.config/i3/polybar/polybar.ini)&
        (MONITOR=$m polybar -q b3 -c $HOME/.config/i3/polybar/polybar.ini)&
    done
else
    polybar --reload --config=$HOME/.config/i3/polybar.ini example &
fi

echo "Bars launched..."
