{
  config,
  lib,
  pkgs,
  ...
}: {
  # Setup a bootloader for the system.
  # Systemd-boot is fine, it also supports secure boot if I want.
  boot.loader = {
    efi.canTouchEfiVariables = lib.mkDefault true;
    systemd-boot.configurationLimit = 10;
    systemd-boot.enable = lib.mkDefault true;
  };

  # Per-interface DHCP is preferred over global DHCP.
  # See each host hardware-configuration.nix file to more info.
  networking.useDHCP = lib.mkDefault false;

  # Remove garbage from my net browsing experience.
  # Hosts file taken from StevenBlack/hosts (Unified+gambling+fakenews+porn)
  # networking.stevenBlackHosts = {
  #   enable = true;
  #   blockFakenews = true;
  #   blockGambling = true;
  #   blockPorn = true;
  # };

  # The dconf store is required for home-manager to apply some configuration
  # to the system, but I don't really use it...
  programs.dconf.enable = true;

  # Base programs for my sanity.
  environment.systemPackages = with pkgs; [
    # The bare-bones stuff.
    coreutils
    gcc
    git
    cached-nix-shell

    # Always keep an editor on hand
    neovim-unwrapped

    # Fetching urls and stuff
    wget
    curl

    # Command line utilities.
    gnugrep # Filtering text streams
    gnused # Editing text streams
    gnumake # MAKEFILES for this.
    tmux # Always having this for a tty.

    # Archive working.
    unzip
    zip
    gzip
    gnutar
    rar
    p7zip
  ];
}
