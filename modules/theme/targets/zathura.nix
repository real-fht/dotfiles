{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.theme.targets.zathura = {
    enable = mkBoolOpt' false "Whether to enable the Zathura PDF reader theme.";
  };

  config = let
    cfg = config.fht.theme.targets.zathura;
    theme = config.fht.theme;
  in
    mkIf cfg.enable {
      home.programs.zathura.options = with theme.colors.withHashtag; {
        completion-bg = black2;
        completion-fg = white;
        completion-group-bg = black2;
        completion-group-fg = white;
        completion-highlight-bg = onebg;
        completion-highlight-fg = accent;
        default-bg = black;
        default-fg = white;
        highlight-active-color = onebg;
        highlight-color = onebg;
        highlight-fg = accent;
        inputbar-bg = darker_black;
        inputbar-fg = white;
        notification-bg = black2;
        notification-error-bg = black2;
        notification-warning-bg = black2;
        notification-fg = white;
        notification-error-fg = red;
        notification-warning-fg = yellow;
        recolor-darkcolor = white;
        recolor-lightcolor = black2;
        render-loading-bg = black;
        render-loading-fg = accent;
        scrollbar-bg = onebg;
        scrollbar-fg = onebg;
        statusbar-bg = darker_black;
        statusbar-fg = grey;
      };
    };
}
