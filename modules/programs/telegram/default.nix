{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.telegram = {
    enable = mkBoolOpt' false "Whether to enable the Telegram chat client.";
  };

  config = let
    cfg = config.fht.programs.telegram;
  in
    mkIf cfg.enable {
      # Use kotatogram, it's way better than the official client.
      user.packages = with pkgs; [kotatogram-desktop];
    };
}
