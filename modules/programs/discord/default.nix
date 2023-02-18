{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.discord = {
    enable = mkBoolOpt' false "Whether to enable the Discord chat client.";
  };

  config = let
    cfg = config.fht.programs.discord;
  in
    mkIf cfg.enable {
      # Install discord with openASAR for an insane startup time and in app performance
      # boost. See https://openasar.dev
      user.packages = [(pkgs.discord.override {withOpenASAR = true;})];

      # Enable the custom theme target.
      fht.theme.targets.discord.enable = true;
    };
}
