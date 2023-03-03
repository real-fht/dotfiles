{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.programs.kitty = {
    enable = mkBoolOpt' false "Whether to enable the Kitty terminal.";
  };

  config = let
    cfg = config.fht.programs.kitty;
  in
    mkIf cfg.enable {
      home.programs.kitty = {
        enable = true;

        font = {
          name = "monospace";
          size = 12.0;
        };

        settings = {
          disable_ligatures = "cursor";
          cursor_shape = "beam";
          cursor_beam_thickness = "1.5";
          window_padding_width = 10;
          background_opacity = "0.95";
        };

        # Better underline.
        extraConfig = ''
          modify_font underline_position 125%
          modify_font underline_thickness 1.25px
          modify_font cell_height 120%
        '';
      };

      # And enable the good terminal colorscheme for kitty.
      fht.theme.targets.kitty.enable = true;
    };
}
