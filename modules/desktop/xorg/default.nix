{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.desktop.xorg = {
    enable = mkBoolOpt' false "Whether to enable X.org";
    greetd.enable =
      mkBoolOpt' (config.fht.desktop.xorg.enable)
      "Whether to enable the greetd display manager";
    xsession.enable = mkBoolOpt' false "Whether to setup a custom Xsession";
  };

  config = let
    cfg = config.fht.desktop.xorg;
  in
    mkMerge [
      (mkIf cfg.enable {
        services.xserver = {
          enable = true;
          autorun = true; # start the dm with my system.
          # Xserver settings
          dpi = 96;
          excludePackages = with pkgs; [xterm];
          updateDbusEnvironment = true;

          # Touchpad settings (synaptics laptop touchpad)
          libinput = {
            enable = true;
            mouse.disableWhileTyping = true;
            mouse.scrollMethod = "twofinger";
            mouse.tapping = true;
          };

          # Just in case something does wrong
          displayManager.startx.enable = true;
        };

        # Allow our user to access the framebuffer.
        user.extraGroups = ["video"];

        # Enable xresources theming.
        fht.theme.targets.xresources.enable = true;
      })

      (mkIf cfg.greetd.enable {
        services.greetd = {
          enable = true; # Duh.
          vt = 2;
          settings = {
            default_session = {
              # Use tuigreetd since it's cleaner and better than the default greetd
              command = ''
                ${pkgs.greetd.tuigreet}/bin/tuigreet --time \
                  --cmd 'startx ./.config/X11/xinitrc' \
                  --user-menu --asterisks \
                  --window-padding 2 --container-padding 4 \
                  --prompt-padding 1 --remember;
              '';
              user = "real";
            };
          };
        };
        # This is to avoid restarting greetd and thus, killing my graphical session.
        # Weird, huh..
        systemd.services.greetd.stopIfChanged = false;
      })

      (mkIf cfg.xsession.enable {
        home.xsession = {
          enable = true;
          initExtra = ''
            ${pkgs.xorg.xmodmap}/bin/xmodmap -e 'keycode 105 = less greater'
            xset dpms 600
          '';

          # Keep my ~/ clean!
          profilePath = ".config/X11/xprofile";
          scriptPath = ".config/X11/xsession";
        };

        # Install an xinitrc that starts X11 using the session
        # One can run then `startx ~/.config/X11/xinitrc`
        home.xdg.configFile."X11/xinitrc" = {
          text = ''
            #!/usr/bin/env bash
            ~/.config/X11/xsession "awesome"
          '';
          executable = true;
        };
      })
    ];
}
