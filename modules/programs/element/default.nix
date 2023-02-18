{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.element = {
    enable = mkBoolOpt' false "Whether to enable the Element chat client.";
  };

  config = let
    cfg = config.fht.programs.element;
  in
    mkIf cfg.enable {
      # Just the element client for matrix.org
      user.packages = [pkgs.element-desktop];
    };
}
