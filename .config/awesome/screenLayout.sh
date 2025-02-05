#!/bin/sh
if xrandr | grep "HDMI-0 disconnected"; then
	xrandr --output "eDP-1" --primary --mode 1920x1080
else
	xrandr --output "HDMI-0" --primary --mode 2560x1440 --output "eDP-1" --left-of "HDMI-0" --mode 1920x1080
fi
