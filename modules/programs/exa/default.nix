{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.exa = {
    enable = mkBoolOpt' false "Whether to enable Exa, the LS replacement";
  };

  config = let
    cfg = config.fht.programs.exa;
  in
    mkIf cfg.enable {
      # Install exa I guess?
      user.packages = [pkgs.exa];

      # Setup custom aliases, i'd rather have custom behaviour such as:
      # - Always showing the icons
      # - Grouping the direcotories at the top
      fht.shell.aliases.ls = "exa --icons -ah --group-directories-first";
      fht.shell.aliases.ll = "exa --icons -la --group-directories-first";
      fht.shell.aliases.llg = "ll --git --header";
      fht.shell.aliases."l." = "exa -la '^.'";
    };
}
