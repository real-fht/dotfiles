{
  config,
  lib,
  ...
}:
lib.mkIf config.modules.desktop.apps.qutebrowser.enable {
  home.configFile."qutebrowser/styles/awesomewm.org.css".text = with config.modules.theme.colors.withHashtag; ''
    html[data-theme='onedark'] {
        --background: ${black};
        --foreground: ${white};
        --color0: ${black2};
        --color1: ${red};
        --color2: ${green};
        --color3: ${yellow};
        --color4: ${blue};
        --color5: ${magenta};
        --color6: ${cyan};
        --color7: ${red};
        --color8: ${oneb2};
        --color9: ${red};
        --colorA: ${green};
        --colorB: ${yellow};
        --colorC: ${cyan};
        --colorD: ${magenta};
        --colorE: ${blue};
        --colorF: ${yellow};
        --background-bright: ${darker_black};
        --color10: ${grey};
        --color11: ${black}44;
        --color12: var(--color7);
        --color13: ${grey}80;
        --color14: var(--colorE);
        --color15: var(--color6);
        --color16: var(--color6);
        --color17: var(--color8);
        --color18: var(--color6);
        --color19: var(--color8);
        --color1A: var(--color6);
        --color1B: ${yellow};
        --color1C: ${grey_fg2};
        --color1D: var(--background);
        --color1E: var(--color4);
        --color1F: var(--colorE);
        --color20: var(--color13);
        --color21: var(--colorE);
        --color22: var(--colorC);
        --color23: var(--colorA);
        --color24: var(--background);
        --color25: var(--background-bright);
        --color26: ${onebg};
        --color27: var(--color6);
        --color28: var(--color23);
        --color29: var(--color20);
        --color30: var(--color1B);
        --color31: var(--color13);
        --color32: var(--colorA);
        --color33: var(--foreground);
        --color34: var(--colorD);
        --color35: var(--colorB);
        --color36: var(--background-bright);
        --color37: var(--color13);
        --color38: var(--color7);
        --color39: var(--color5);
        --color40: var(--color5);
        --color100: ${onebg};
        --color101: var(--color1);
        --color102: var(--color7);
        --color103: var(--color7);
        --color104: var(--color6);
        --color105: var(--color7);
        --color106: var(--color1);
        --color107: var(--color5);
        --color108: var(--color9);
        --color109: var(--color2);
        --color10A: var(--color4);
        --color10B: var(--color6);
        --color10C: var(--colorA);
        --color10D: var(--color2);
        --color10E: var(--color8);
        --color10F: var(--colorB);
        --color110: var(--foreground);
    }'';
}
