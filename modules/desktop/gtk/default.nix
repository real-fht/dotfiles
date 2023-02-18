{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.desktop.gtk = {
    enable = mkEnableOption (mdDoc "gtk");
    qtSupport = mkEnableOption (mdDoc "QT/QT6 support");
  };

  config = let
    cfg = config.fht.desktop.gtk;
  in
    mkMerge [
      (mkIf cfg.enable {
        home.gtk = {
          # Enable gtk support, I guess.
          enable = true;

          # Keep my ~/ clean!!!
          gtk2 = {configLocation = "${config.user.home}/.config/gtk-2.0";};

          gtk3 = {
            bookmarks = [
              "file:///${config.user.home}/Downloads"
              "file:///${config.user.home}/Documents"
              "file:///${config.user.home}/Pictures"
              "file:///${config.user.home}/Music"
              "file:///${config.user.home}/repo"
              "file:///${config.user.home}/.config"
              "file:///${config.user.home}/.local/share"
            ];
          };

          cursorTheme = {
            package = pkgs.phinger-cursors;
            name = "phinger-cursors-light";
            size = 32;
          };

          iconTheme = {
            # The cleanest icon theme
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
          };

          theme = {
            # Matches with the system's color definition
            name = "phocus";
            package = pkgs.phocus.override {
              colors = with config.fht.theme.base16.withoutHashtag; {
                base00 = base00;
                base01 = base01;
                base02 = base02;
                base03 = base03;
                base04 = base04;
                base05 = base05;
                base06 = base06;
                base07 = base07;
                base08 = base08;
                base09 = base09;
                base0A = base0A;
                base0B = base0B;
                base0C = base0C;
                base0D = base0D;
                base0E = base0E;
                base0F = base0F;
              };

              primary = config.fht.theme.colors.withoutHashtag.accent;
              secondary = config.fht.theme.colors.withoutHashtag.secondary_accent;
            };
          };
        };

        home.home.pointerCursor = {
          package = pkgs.phinger-cursors;
          name = "phinger-cursors-light";
          size = 32;
          # Apply to X11 session
          x11.enable = true;
        };
      })

      (mkIf cfg.qtSupport {
        # System-wide qt settings.
        qt = {
          enable = true;
          platformTheme = "qt5ct";
        };

        # User qt settings.
        home.qt = {
          enable = true;
          platformTheme = "gtk";
          style.package = pkgs.libsForQt5.qtstyleplugins;
          style.name = "gtk2";
        };
      })
    ];
}
