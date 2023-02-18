{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.sxiv = {
    enable = mkBoolOpt' false "Whether to enable the sxiv image viewer";
  };

  config = let
    cfg = config.fht.programs.sxiv;
  in
    mkIf cfg.enable {
      # Just install it ffs
      user.packages = [pkgs.sxiv];
    };
}
