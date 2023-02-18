#!/usr/bin/env zsh

# ~/.config/zsh/.zshenv -*- Environment setup for zsh.

# Safely source given configuration files.
# By that I mean that it won't crash execution if the given file isn't readable
# or doesn't exist.
function _source { for file in "$@"; do; [ -r $file ] && source $file; done; }

# Be more restrictive with permissions; no one has any business reading things
# that don't belong to them.
(( EUID != 0 )) && umask 027 || 077

# Home manager session variables.
# This is set because some options in home manager relies on home.sessionVariables
# to work properly, such as FZF settings.
. /nix/var/nix/profiles/per-user/real/home-manager/home-path/etc/profile.d/hm-session-vars.sh
