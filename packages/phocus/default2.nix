{
  config,
  pkgs,
  ...
}: let
  base16 = config.fht.theme.colors.base16.withoutHashtag;
  colors = config.fht.theme.colors.colors.withoutHashtag;
in
  pkgs.phocus.override {
    colors = with base16; {
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

    primary = colors.accent;
    secondary = colors.secondary_accent;
  }
