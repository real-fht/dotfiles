{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.theme.targets.neovim = {
    enable = mkBoolOpt' false "Whether to enable the Neovim editor theme.";
  };

  config = let
    cfg = config.fht.theme.targets.neovim;
    theme = config.fht.theme;
  in
    mkIf cfg.enable {
      home.xdg.configFile."theme/neovim/colors.lua".text = with theme.colors.withHashtag; "	-- HEY, don't edit this! It was autogenerated by nix.\n	-- Current theme: ${theme.name}\n	return {\n			black        = \"${black}\",\n			darker_black = \"${darker_black}\",\n			black2       = \"${black2}\",\n			onebg        = \"${onebg}\",\n			oneb2        = \"${oneb2}\",\n			oneb3        = \"${oneb3}\",\n			statusline   = \"${statusline}\",\n			white        = \"${white}\",\n			grey         = \"${grey}\",\n			grey_fg      = \"${grey_fg}\",\n			grey_fg2     = \"${grey_fg2}\",\n			light_grey   = \"${light_grey}\",\n			red          = \"${red}\",\n			green        = \"${green}\",\n			yellow       = \"${yellow}\",\n			blue         = \"${blue}\",\n			magenta      = \"${magenta}\",\n			cyan         = \"${cyan}\",\n	}\n";

      home.xdg.configFile."theme/neovim/base16.lua".text = with theme.base16.withHashtag; "	-- HEY, don't edit this! It was autogenerated by nix.\n	-- Current theme: ${theme.name}\n	return {\n			BASE00 = \"${base00}\",\n			BASE01 = \"${base01}\",\n			BASE02 = \"${base02}\",\n			BASE03 = \"${base03}\",\n			BASE04 = \"${base04}\",\n			BASE05 = \"${base05}\",\n			BASE06 = \"${base06}\",\n			BASE07 = \"${base07}\",\n			BASE08 = \"${base08}\",\n			BASE09 = \"${base09}\",\n			BASE0A = \"${base0A}\",\n			BASE0B = \"${base0B}\",\n			BASE0C = \"${base0C}\",\n			BASE0D = \"${base0D}\",\n			BASE0E = \"${base0E}\",\n			BASE0F = \"${base0F}\",\n	}\n";
    };
}
