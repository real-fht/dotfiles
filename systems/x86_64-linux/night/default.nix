{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  ### CONFIGURATION MANAGED BY MODULES.

  fht = let
    enable = {enable = true;};
  in {
    # Desktop configuration, where you can enable settings for the desktop experience.
    # This includes settings for which apps you want, that terminals you want to use,
    # Xorg settings, etc.
    desktop = {
      # Themeing toolkit support
      gtk = enable // {qtSupport = true;};

      # Xorg settings.
      xorg = {
        enable = true;
        greetd.enable = true;
        xsession.enable = true;
      };

      # Window managers/compositors
      # I guess sometime I'll rice something else than AwesomeWM, maybe i3/bspwm?
      windowManagers = {awesomewm.enable = true;};
    };

    # Theming, everything is handled by NixOS!
    theme.name = "decay-dark";

    # Enable/disable programs, aswell as setup my configuration and optionally the
    # current system theme for the enabled program.
    programs = {
      audacity = enable;
      discord = enable;
      # element   = enable;
      exa = enable;
      fzf = enable;
      git =
        enable
        // {
          userName = "real-fht";
          userEmail = "nferhat20@gmail.com";
        };
      gnupg = enable // {gitIntegration = enable // {key = "79E6CEB6B608B845";};};
      kitty = enable;
      neovim = enable;
      # obs = enable;
      qutebrowser = enable;
      shotcut = enable;
      steam = enable;
      sxiv = enable;
      telegram = enable;
      zathura = enable;
      zoxide = enable;
    };

    # Shell configuration.
    shell = {zsh = enable;};

    # Services configuration.
    # Nothing special, just services that I tend to use.
    services = {
      picom = enable;
      flameshot = enable;
      ssh = enable;
      redshift = enable;
    };

    # Hardware configuration.
    # Nothing special, just configure to match your hardware I guess.
    hardware = {
      bluetooth.enable = true;

      # Graphics configuration.
      # Sets up video acceleration, opengl, openal, and offloading.
      # There's a guide on nixos.wiki to get the busId of the nvidia and intel cards.
      graphics = {
        enable = true;
        # Nvidia gpu setup.
        nvidia.enable = true;
        nvidia.busId = "PCI:1:0:0";
        # Intel gpu setup.
        intel.enable = true;
        intel.busId = "PCI:0:2:0";
      };

      # Input setup, nothing interesing here except keyboardLayout,
      # for now...
      input.keyboardLayout = "fr";

      # Enable networking using NetworkManager (nmcli, nmtui, etc...)
      # It's also the default for many distributions for it's ease of use
      networking = enable;

      # Audio setup using Pipewire as the audio server.
      # Alsa/Pulse/Jack emulation is done by pipewire too.
      sound = {
        enable = true;
        alsa.enable = true;
        bluetooth.enable = true;
        # jack.enable = false;
        pulseaudio.enable = true;
      };
    };
  };

  ### LOCAL CONFIGURATION FOR THE MACHINE.

  # Locale setup
  time = {
    timeZone = "Africa/Algiers";
    # Required for windows dualboot time sync
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_US.UTF-8";

  # Kernel setup.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["acpi_backlight=video" "elevator=bfq"];

  # Enable networking using NetworkManager (nmcli, nmtui, etc...)
  # It's also the default for many distributions for it's ease of use

  # Better performance on demand for games and some programs
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  # Controls the backlight for users in the video group
  hardware.acpilight.enable = true;

  # To monitor and control my batter.
  services.upower = {
    enable = true;
    # In case I forget to charge by laptop
    criticalPowerAction = "Hibernate";
    ignoreLid = false;
  };

  # Just don't touch this, and don't read the comment
  # This is for backwards compatibility
  system.stateVersion = lib.mkForce "22.11";
}
