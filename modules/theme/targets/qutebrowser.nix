{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.theme.targets.qutebrowser = {
    enable =
      mkBoolOpt' false "Whether to enable Qutebrowser web browser theme.";
  };

  config = let
    cfg = config.fht.theme.targets.discord;
    theme = config.fht.theme;
  in
    mkIf cfg.enable {
      home.programs.qutebrowser.settings = with theme.colors.withHashtag; {
        "colors.completion.category.bg" = onebg;
        "colors.completion.category.border.bottom" = onebg;
        "colors.completion.category.border.top" = onebg;
        "colors.completion.category.fg" = white;
        "colors.completion.even.bg" = black2;
        "colors.completion.item.selected.bg" = onebg;
        "colors.completion.item.selected.border.bottom" = onebg;
        "colors.completion.item.selected.border.top" = onebg;
        "colors.completion.item.selected.fg" = blue;
        "colors.completion.item.selected.match.fg" = blue;
        "colors.completion.match.fg" = red;
        "colors.completion.odd.bg" = black2;
        "colors.completion.scrollbar.bg" = black2;
        "colors.completion.scrollbar.fg" = black2;
        "colors.contextmenu.disabled.bg" = black2;
        "colors.contextmenu.disabled.fg" = grey;
        "colors.contextmenu.menu.bg" = black2;
        "colors.contextmenu.menu.fg" = white;
        "colors.contextmenu.selected.bg" = onebg;
        "colors.contextmenu.selected.fg" = blue;
        "colors.downloads.bar.bg" = black;
        "colors.downloads.error.bg" = onebg;
        "colors.downloads.error.fg" = red;
        "colors.downloads.start.bg" = onebg;
        "colors.downloads.start.fg" = blue;
        "colors.downloads.stop.bg" = onebg;
        "colors.downloads.stop.fg" = green;
        "colors.hints.bg" = onebg;
        "colors.hints.fg" = white;
        "colors.hints.match.fg" = red;
        "colors.keyhint.bg" = black;
        "colors.keyhint.fg" = white;
        "colors.keyhint.suffix.fg" = yellow;
        "colors.messages.error.bg" = black2;
        "colors.messages.error.border" = black2;
        "colors.messages.error.fg" = red;
        "colors.messages.info.bg" = black2;
        "colors.messages.info.border" = black2;
        "colors.messages.info.fg" = blue;
        "colors.messages.warning.bg" = black2;
        "colors.messages.warning.border" = black2;
        "colors.messages.warning.fg" = yellow;
        "colors.prompts.bg" = black2;
        "colors.prompts.border" = "2px solid ${black}";
        "colors.prompts.fg" = white;
        "colors.prompts.selected.bg" = onebg;
        "colors.prompts.selected.fg" = blue;
        "colors.statusbar.caret.bg" = black;
        "colors.statusbar.caret.fg" = magenta;
        "colors.statusbar.caret.selection.bg" = black;
        "colors.statusbar.caret.selection.fg" = red;
        "colors.statusbar.command.bg" = black;
        "colors.statusbar.command.fg" = white;
        "colors.statusbar.insert.bg" = black;
        "colors.statusbar.insert.fg" = green;
        "colors.statusbar.normal.bg" = black;
        "colors.statusbar.normal.fg" = white;
        "colors.statusbar.passthrough.bg" = black;
        "colors.statusbar.passthrough.fg" = blue;
        "colors.statusbar.private.bg" = black;
        "colors.statusbar.private.fg" = white;
        "colors.statusbar.progress.bg" = green;
        "colors.statusbar.url.error.fg" = red;
        "colors.statusbar.url.fg" = white;
        "colors.statusbar.url.hover.fg" = cyan;
        "colors.statusbar.url.success.http.fg" = green;
        "colors.statusbar.url.success.https.fg" = green;
        "colors.statusbar.url.warn.fg" = yellow;
        "colors.tabs.bar.bg" = black;
        "colors.tabs.even.bg" = black2;
        "colors.tabs.even.fg" = grey;
        "colors.tabs.indicator.error" = red;
        "colors.tabs.indicator.start" = blue;
        "colors.tabs.indicator.stop" = green;
        "colors.tabs.indicator.system" = "rgb";
        "colors.tabs.odd.bg" = black2;
        "colors.tabs.odd.fg" = grey;
        "colors.tabs.pinned.even.bg" = onebg;
        "colors.tabs.pinned.even.fg" = grey;
        "colors.tabs.pinned.odd.bg" = onebg;
        "colors.tabs.pinned.odd.fg" = grey;
        "colors.tabs.pinned.selected.even.bg" = black;
        "colors.tabs.pinned.selected.even.fg" = green;
        "colors.tabs.pinned.selected.odd.bg" = black;
        "colors.tabs.pinned.selected.odd.fg" = green;
        "colors.tabs.selected.even.bg" = black;
        "colors.tabs.selected.even.fg" = white;
        "colors.tabs.selected.odd.bg" = black;
        "colors.tabs.selected.odd.fg" = white;
        "colors.webpage.bg" = black2;
        "hints.border" = "2px solid " + black2;
      };
    };
}
