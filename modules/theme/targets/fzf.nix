{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.theme.targets.fzf = {
    enable = mkBoolOpt' false "Whether to enable the FZF fuzzy finder theme.";
  };

  config = let
    cfg = config.fht.theme.targets.fzf;
    theme = config.fht.theme;
  in
    mkIf cfg.enable {
      home.programs.fzf.colors = with theme.colors.withHashtag; rec {
        fg = white;
        bg = black;
        preview-fg = fg;
        preview-bg = bg;
        hl = yellow;
        "fg+" = white;
        "bg+" = onebg;
        gutter = bg;
        "hl+" = accent;
        info = grey_fg2;
        border = oneb2;
        prompt = bg;
        pointer = blue;
        marker = yellow;
        spinner = magenta;
        header = accent;
      };
    };
}
