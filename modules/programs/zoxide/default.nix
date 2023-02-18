{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.programs.zoxide = {
    enable = mkBoolOpt' false "Whether to enable Zoxide directory jumping.";
  };

  config = let
    cfg = config.fht.programs.zoxide;
  in
    mkIf cfg.enable {
      # Enable zoxide for our user.
      home.programs.zoxide.enable = true;

      # Initialize zoxide using our custom rc setup.
      fht.shell.extraInit = ''
        # Initialize zoxide for directory jumping.
        [ ! -z $ZSH_VERSION ] && eval "$(zoxide init zsh)"
      '';
    };
}
