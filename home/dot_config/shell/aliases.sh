#!/usr/bin/env dash

# ~/.config/shell/aliases.sh -*- Global aliases for POSIX-compliant shells
# Basically everything, excluding fish lmao

# Just gotta save typing three letters out of one program.
alias da="doas --" \
    pm="pulsemixer" \
    nmt="nmtui-connect" \
    bt="bluetoothctl" \
    vim="nvim" \
    v="nvim" \
    tb="nc termbin.com 9999";

# Default options for some programs
alias less="less --use-color --color=Pbk --color=NK- --force --ignore-case --incsearch -N" \
    grep="grep --extended-regexp --ignore-case --with-filename --color=auto" \
    ip="ip -h -s --color=always" \
    diff="diff --color=auto"

# Safer move, copy, and delete operations
alias mv="mv -fv --" cp="cp -LfRv --" rm="rm -Idrv --";

# Use my $EDITOR as the default for v/vim/e
alias e="$EDITOR" v="$EDITOR" vim="$EDITOR"

# Make directory but it's idempotent.
alias mkdir="mkdir -pv";
# A better mkdirectory.
function md { mkdir -pv "${1}" && cd "${1}" || return; };

# An rsync that respects gitignore
# Stolen from Henrik Lissner's dotfiles.
rcp() {
  # -a = -rlptgoD
  #   -r = recursive
  #   -l = copy symlinks as symlinks
  #   -p = preserve permissions
  #   -t = preserve mtimes
  #   -g = preserve owning group
  #   -o = preserve owner
  # -z = use compression
  # -P = show progress on transferred file
  # -J = don't touch mtimes on symlinks (always errors)
  rsync -azPJ --include=.git --filter=':- .gitignore'  \
    --filter=":- $XDG_CONFIG_HOME/git/ignore" "$@"
}
# Some additional variants of this command.
alias rcpd='rcp --delete --delete-after' \
    rcpu='rcp --chmod=go=' \
    rcpdu='rcpd --chmod=go='

# Create a reminder with human-readable durations, e.g. 15m, 1h, 40s, etc
function r {
  local time=$1; shift
  local urgency=${2:-normal}; shift
  sched "$time" "notify-send --urgency=critical '${urgency}' '$@'; ding";
};

# I don't like ~/.local/share/chezmoi as the default.
if command -v chezmoi >/dev/null; then
  function cm { chezmoi "$@" -S ~/Documents/dotfiles; }
fi

# Setup exa as a modern GNU/ls replacement
if command -v exa >/dev/null; then
  alias \
    ls="exa --icons -ah --group-directories-first" \
    ll="exa --icons -la --group-directories-first" \
    llg="ll --git --header" \
    l.="exa -la '^.'"
fi

# Easier to copy/paste stuff from the terminal.
if command -v xclip >/dev/null; then
  alias yank='xclip -selection clipboard -in' \
    paste='xclip -selection clipboard -out'
fi

# Behold! Git aliases here.
# Git has a builtin alias system, but the redundancy of typing "g<space>alias"
# gets really annoying!
if command -v git >/dev/null; then
  alias g="git" \
    gc="git commit" \
    gco="git checkout" \
    ga="git add" \
    gaa="git add -A" \
    gA="git add -A" \
    gb="git branch" \
    gba="git branch --all" \
    gbd="git branch -D" \
    gd="git diff -w" \
    gds="git diff -w --staged" \
    gcp="git cherry-pick" \
    grs="git restore --staged" \
    gst="git rev-parse --git-dir > /dev/null 2>&1 && git status || exa" \
    gu="git reset --soft HEAD~1" \
    gpr="git remote prune origin" \
    ff="gpr && git pull --ff-only" \
    grd="git fetch origin && git rebase origin/master" \
    gbf="git branch | head -1 | xargs" \
    grc="git rebase --continue" \
    gra="git rebase --abort"
fi
