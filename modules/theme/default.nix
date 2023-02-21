{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = lib.files.get-nix-files-recursive ./targets;

  options.fht.theme = with types; {
    name = let
      themes = lib.files.get-directories ./themes;
      themes_name = map (theme_path: builtins.baseNameOf theme_path) themes;
    in
      mkOpt' (enum themes_name) "gruvchad"
      (mdDoc "What theme palette to use?");
    wallpaper = mkOpt (either path null) null;

    # Going to be filled in config section.
    colors.withoutHashtag = mkOpt attrs {};
    colors.withHashtag = mkOpt attrs {};
    # -*-
    base16.withoutHashtag = mkOpt attrs {};
    base16.withHashtag = mkOpt attrs {};

    # To reload all the system colors!
    onReload = mkOpt (attrsOf lines) {};
  };

  config = let
    cfg = config.fht.theme;
  in
    mkMerge [
      {
        # Color definition (without hashtag)
        fht.theme.colors.withoutHashtag = import ./themes/${cfg.name}/colors.nix;
        # Color definition (with hashtag)
        fht.theme.colors.withHashtag =
          mapAttrs (n: v: "#" + v) cfg.colors.withoutHashtag;

        # Base16 definition (without hastag).
        fht.theme.base16.withoutHashtag = with cfg.colors.withoutHashtag; {
          base00 = black;
          base01 = black2;
          base02 = onebg;
          base03 = grey;
          base04 = grey_fg;
          base05 = white;
          base06 = light_grey;
          base07 = oneb3;
          base08 = red;
          base09 = yellow; # or orange, based on the used color
          base0A = yellow;
          base0B = green;
          base0C = cyan;
          base0D = blue;
          base0E = magenta;
          base0F = red; # or a darker red variant
        };
        # Base16 definition (with hashtag)
        fht.theme.base16.withHashtag =
          mapAttrs (_: v: "#" + v) cfg.base16.withoutHashtag;

        # Set the wallpaper.
        fht.theme.wallpaper = ./themes/${cfg.name}/wall.jpg;
      }
      (let
        reloadTheme = with pkgs; (writeScriptBin "reloadTheme" ''
          #!${stdenv.shell}
          echo "Reloading current theme: ${cfg.name}"
          ${concatStringsSep "\n"
            (mapAttrsToList (name: script: ''
                echo "[${name}]"
                ${script}
              '')
              cfg.onReload)}
        '');
      in {
        user.packages = [reloadTheme];
        system.userActivationScripts.reloadTheme = ''
          [ -z "$NORELOAD" ] && ${reloadTheme}/bin/reloadTheme
        '';
      })

      (mkIf (cfg.wallpaper
        != null) (let
        wallCmd = ''
          [ -e "$XDG_DATA_HOME/wallpaper" ] && \
            ${pkgs.feh}/bin/feh --bg-fill --no-fehbg \
            $XDG_DATA_HOME/wallpaper
        '';
      in {
        fht.theme.onReload.wallpaper = wallCmd;
        home.xsession.initExtra = wallCmd;
        home.xdg.dataFile."wallpaper".source = cfg.wallpaper;
      }))
    ];
}
