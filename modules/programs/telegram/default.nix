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
      # Install the desktop and cli version of telegram, useful for example when I'm
      # inside a tty/terminal only environment.
      user.packages = with pkgs; [tdesktop telegram-cli];
    };
}
