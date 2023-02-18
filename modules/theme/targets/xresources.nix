{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.theme.targets.xresources = {
    enable = mkBoolOpt' false "Whether to enable Xresource theme variables.";
  };

  config = let
    cfg = config.fht.theme.targets.xresources;
    theme = config.fht.theme;
  in
    mkIf cfg.enable {
      home.xresources = {
        # Keep my ~/ clean!
        path = "${config.user.home}/.config/X11/xresources";
        # And setup xresources
        properties = with theme.colors.withHashtag; {
          "*background" = black;
          "*foreground" = white;
          "*color1" = red;
          "*color9" = red;
          "*color2" = green;
          "*color10" = green;
          "*color3" = yellow;
          "*color11" = yellow;
          "*color4" = blue;
          "*color12" = blue;
          "*color5" = magenta;
          "*color13" = magenta;
          "*color6" = cyan;
          "*color14" = cyan;
          "*color7" = white;
          "*color15" = white;
          # For compatibility reasons.
          "background" = black;
          "foreground" = white;
        };
      };
    };
}
