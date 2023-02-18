#!/usr/bin/env zsh

# ~/.config/zsh/prompt.zsh -*- Setup the Z-shell prompt.

# Since I don't wanna go through the fuss of setting a prompt myself with
# variables, executing commands, etc... I just leave starship do the work
# for me!
if command -v starship >/dev/null; then
  eval "`starship init zsh`"
fi
