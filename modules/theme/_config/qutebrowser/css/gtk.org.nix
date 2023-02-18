{
  config,
  lib,
  ...
}:
lib.mkIf config.modules.desktop.apps.qutebrowser.enable {
  home.configFile."qutebrowser/styles/gtk.org.css".text = with config.modules.theme.colors.withHashtag; ''
    :root {
        --text-color: ${white};
        --text-color-muted: ${grey_fg2};
        --primary: ${accent};
        --body-bg: ${black};
        --sidebar-primary: ${accent};
        --sidebar-bg: ${darker_black};
        --sidebar-selected-bg: ${onebg};
        --sidebar-hover-bg: ${black2};
        --sidebar-text-color: ${light_grey};
        --sidebar-search-bg: ${black2}AB;
        --sidebar-search-focus-bg: ${black2};
        --sidebar-padding: 1.5em;
        --warning-bg-color: ${black2}AB;
        --warning-fg-color: ${yellow};
        --error-bg-color: ${black2}AB;
        --error-fg-color: ${red};
        --accent-bg-color: ${oneb2};
        --accent-fg-color: ${accent};
        --box-bg: ${onebg};
        --box-radius: 0.35rem;
        --box-padding: 0.75rem;
        --box-margin: 0.75rem 0;
        --box-text-color: ${white};
        --body-font-family: "Red Hat Text",-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";
        --body-font-scale: 0.95;
        --body-font-size: calc(var(--body-font-scale) * clamp(16px, 1vw, 18px));
        --body-font-weight: normal;
        --monospace-font-family: "Source Code Pro", monospace;
        --monospace-font-size: calc(0.86 * var(--body-font-size));
        --heading-font-family: "Red Hat Display", var(--body-font-family);
        --heading-weight: 900;
        --heading-font-scale: 1.05;
        --heading-small-font-family: var(--heading-font-family);
        --heading-small-weight: 600;
        --heading-small-font-scale: 1;
        --heading-table-font-family: var(--heading-font-family);
        --heading-table-weight: 600;
        --heading-docblock-color: ${onebg};
        --heading-docblock-scale: 0.9;
        --symbol-font-family: var(--heading-font-family);
        --symbol-font-weight: 500;
        --symbol-font-scale: 1;
        --table-font-size: 0.92em;
        --preferred-content-width: 90ch;
        --anchor-sign: "#";
    }
  '';
}
