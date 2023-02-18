#!/usr/bin/env zsh

# ~/.config/zsh/.zprofile -*- Profile initialization for zsh.

# This will not do alot, since most of the environment initialization is done
# by NixOS, and thus, declared somewhere inside the modules.

# Automatically startx when I'm logging in on /dev/tty1
XINITRC=~/.config/X11/xinitrc
if [ ! $DISPLAY ] && [ ! $(pgrep X) ] && [ $(tty) = "/dev/tty1" ]; then
    # Just to make stuff clear!
    clear && startx $XINITRC
fi
