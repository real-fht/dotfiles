#!/usr/bin/env sh

# ~/.config/shell/profile.sh -*- Environment init for each POSIX-compliant shell

# Ensure some default programs are actually used.
export EDITOR="nvim"
export PAGER="less"
export VISUAL="${TERMINAL} -e ${EDITOR}"
export BROWSER="librewolf-bin"

# Ensuring XDG compliancy with environment variables.
# The first step of doing this is to make sure that XDG_* variables exist.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
# -*- Now time to apply settings.
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="$XDG_CCACHE_HOME/less/history"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export WGETRC="$XDG_CONFIG_HOME/wget/rc";
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME/nv"

# Less settings.
# This is mainly to ensure coloring.
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"

# Always initiate new shells with gpg_tty
export GPG_TTY=$(tty)

# Extend the PATH variable to include personal shell scripts.
path_prepend="$HOME/.local/bin:$CARGO_HOME/bin"
path_append=""
export PATH="${path_prepend}:${PATH}:${path_append}"
