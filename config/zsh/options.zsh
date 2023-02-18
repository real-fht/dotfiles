#!/usr/bin/env zsh

# ~/.config/zsh/options.zsh -*- Settings for the Z shelL.
# Check `man 1 zshoptions` for additional options.

##       Changing directories
setopt   AUTO_CD              # If an issued command is a valid path, cd to it.
setopt   AUTO_PUSHD           # Auto push the old path to the dir stack with cd.
setopt   PUSHD_IGNORE_DUPS    # Avoid duplicate entries in the dir stack with ^

##       Completion
setopt   ALWAYS_TO_END        # Put the cursor at the end of a completion after issuing it.
setopt   AUTO_LIST            # Automatically list choices on ambiguous completions
setopt   AUTO_PARAM_SLASH     # If the completed item is a directory, add a slash at the end.
setopt   AUTO_REMOVE_SLASH    # Remove the trailing slash (from ^) if you hit space/semicolon/...
unsetopt LIST_BEEP            # DONT Beep on ambiguous completion
setopt   LIST_ROWS_FIRST      # Layout matches horizontally first, then vertically;
setopt   MENU_COMPLETE        # On ambiguous completions, list options using a menu.

##       Expansion and Globbing
setopt   BAD_PATTERN          # Print error message if glob pattern is wrong
setopt   CASE_GLOB            # Make globbing case sensitive, why isn't this on by default?
setopt   GLOB_STAR_SHORT      # Abbrevaitions for some globbing patterns that use *

##       History
setopt   BANG_HIST            # Expand history entries, like csh, treating the bang specially.
setopt   EXTENDED_HISTORY     # More information in the history file.
setopt   HIST_IGNORE_DUPS     # Ignore duplicates from history files, makes them cleaner.
setopt   HIST_NO_FUNCTIONS    # Don't log function definitions.
HISTFILE="$ZSH_CACHE/history" # Keep my home clean!!

##       Initialization
unsetopt GLOBAL_RCS           # Load /etc/{zprofile,zshrc,zlogin,zlogout}

##       Input/Output
setopt   ALIASES              # Use aliases that are defined.
setopt   INTERACTIVE_COMMENTS # Enable usage of comments, even in interactive shells.

##       ZLE (Zsh Line Editor)
setopt   VI                   # Enable the included Vim mode
