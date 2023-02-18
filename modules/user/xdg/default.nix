{...}:
# Setup XDG compliance for my user.
# This module only handles general cases, by setting some environment variables
# and other stuff (taken from ArchLinux's XDG base directory article)
#
# For programs that require more complex setups for XDG compliance, check the
# program's module file inside the config section.
{
  # Enable xdg for my user.
  home.xdg.enable = true;

  # Setup XDG-compliant variables as soon as the user logs in.
  # Yes this is also done by user-hm.xdg.enable; but setting this early to avoid
  # race conditions.
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_BIN_HOME = "$HOME/.local/bin";
    # For linking stuff.
    DOTFILE_FLAKE = "/etc/nixos";
  };

  # Set environment variables to setup xdg compliancy for certain programs.
  # These are set after environment.sessionVariables to ensure that our XDG directory
  # variables are actually set
  environment.variables = {
    # Some programs environment settings for xdg compliance.
    __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    HISTFILE = "$XDG_DATA_HOME/bash/history";
    LESSHISTFILE = "$XDG_CACHE_HOME/lesshst";
    WGETRC = "$XDG_CONFIG_HOME/wgetrc";
    GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0";
    WINEPREFIX = "$XDG_DATA_HOME/wineprefixes/default"; # instead of ~/.wine
    GOPATH = "$XDG_DATA_HOME/go"; # instead of ~/go
    CARGO_HOME = "$XDG_DATA_HOME/cargo"; # instead of ~/.cargo
    # Environment setup so zsh loads configuration files **from** ~/.config/zsh.
    # Using this approach avoids us writing a ~/.zshenv
    ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
    ZSH_CACHE = "$XDG_CACHE_HOME/zsh";
    ZGEN_DIR = "$XDG_DATA_HOME/zgenom";
  };

  # Move ~/.Xauthority out of $HOME (setting XAUTHORITY early isn't enough)
  # Also remove ~/.serverauth* since it's annoying.
  environment.extraInit = ''
    export XAUTHORITY=/tmp/Xauthority
    [ -e ~/.Xauthority ] && mv -f ~/.Xauthority "$XAUTHORITY"
  '';

  # MIME support for default apps and stuff.
  home.xdg.mime.enable = true;
  home.xdg.mimeApps.enable = true;
}
