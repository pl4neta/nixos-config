#!/bin/sh

run() {
    if ! pgrep -f "$1"; then
        "$@"&
    fi
}

#xinput set-prop 'SYNA2B46:00 06CB:CD5F Touchpad' 'libinput Tapping Enabled' 1
#run 'picom'
#eww daemon&
#caffeine start&
`which eww` -c $HOME/.dotfiles/.config/eww/bar open bar&
#exec '~/.fehbg'

#run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" &
#run "keepassxc" &
#run "xscreensaver" --no-splash &
#run "volumeicon" &
#run "nm-applet" &
#run "ibus-daemon" -drxR &
#run "caffeine" &
#run "feh" --randomize --recursive --bg-fill ~/Pictures/Wallpapers/ &
#run "picom" -b &
#run "cbatticon" -n &
# run "" &
