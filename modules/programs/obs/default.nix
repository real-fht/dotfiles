{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.obs = {
    enable =
      mkBoolOpt' false "Whether to enable the Open Broadcasting Software.";
  };

  config = let
    cfg = config.fht.programs.obs;
  in
    mkIf cfg.enable {
      # Streaming and recording + Video utility.
      user.packages = with pkgs; [obs-studio handbrake];
    };
}
