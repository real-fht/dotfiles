{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.audacity = {
    enable = mkBoolOpt' false "Whether to enable the Audacity audio utility.";
  };

  config = let
    cfg = config.fht.programs.audacity;
  in
    mkIf cfg.enable {
      # Recording/Mixing/Having fun with audio
      user.packages = with pkgs; [audacity ardour];
    };
}
