#!/usr/bin/env zsh

# ~/.config/zsh/compinit.zsh -*- Zsh's completion system setup!

# Don't use $ZDOTDIR for the completion dump
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump

# Enable the basic completer, approximate, and glob completer.
zstyle ':completion:*' completer _extensions _complete _approximate _expand_alias

# Enable completion caching since big commands (like emerge) can take quite some
# time to load all the possible completions.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/compcache"

# Sort all the possible completion options in a pretty menu
zstyle ':completion:*' menu select

# Custom styles for messages above completion menu
zstyle ':completion:*:descriptions' format '%F{blue}->%f %BCompleting%b: %F{blue}%d%f'
zstyle ':completion:*:corrections'  format '(%BErrors%b: %F{red}%e%f)'
zstyle ':completion:*:messages'	    format '%F{purple}==%f %d'
zstyle ':completion:*:warnings'     format '%F{yellow}->%f No matches: %d'

# Sort file items based on how recently they have been modified.
zstyle ':completion:*' file-sort modification

# Display all file info when completing files.
zstyle ':completion:*' file-list all
# zstyle ':completion:*' list-colors $\{s.:. LS_COLORS\} # This is for colors.

# Expand partial paths, e.g. cd f/b/z == cd foo/bar/baz
zstyle ':completion:*:paths' path-completion yes

# Don't complete uninteresting users
# IE: users managed by the system for system tasks, like the nixbld users, or the
# systemd users. Also daemon users.
zstyle ':completion:*:users' ignored-patterns \
  adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
  dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
  hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
  mailman mailnull mldonkey mysql nagios \
  named netdump news nfsnobody nobody 'nixbld*' nscd ntp nut nx openvpn \
  operator pcap postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm shutdown squid sshd sync 'systemd-*' uucp vcsa xfs '_*'

# Omit parent and current directories from completion results when they are
# already named in the input.
zstyle ':completion:*:*:cd:*' ignore-parents parent pwd

# Manpages completion settings.
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# SSH/SCP/RSYNC completion
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Squeeze two slashes in / ("//" -> "/") like most unix systems.
zstyle ':completion:*' squeeze-slashes true

# Do a case insensitive completion and reload it live.
zstyle ':completion:*' matcher-list ' ' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Styling for the kill command. (Taken from github:Awan/cfg)
zstyle ':completion::*:kill:*:*' command 'ps x -U $USER -o pid,%cpu,cmd'
zstyle ':completion::*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'

# The following allows to navigate the completion menu with HJKL (vim) keys.
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Like my neovim configuration, Ctrl-Space opens a completion menu
bindkey '^ ' complete-word
