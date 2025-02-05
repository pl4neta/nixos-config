#!/bin/sh
sh ~/.config/awesome/screenLayout.sh
`which eww` -c $HOME/.dotfiles/.config/eww/bar open bar&
echo 'awesome.restart()' | awesome-client
