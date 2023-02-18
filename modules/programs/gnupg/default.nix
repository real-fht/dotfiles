{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.gnupg = with types; {
    enable = mkBoolOpt' false "Whether to enable gnupg.";
    gitIntegration = {
      enable = mkBoolOpt' false "Whether to enable gnupg signing for git";
      key = mkOpt str "";
    };
  };

  config = let
    cfg = config.fht.programs.gnupg;
  in
    mkMerge [
      (mkIf cfg.enable {
        environment.variables.GNUPGHOME = "$XDG_CONFIG_HOME/gnupg";
        programs.gnupg.agent.enable = true;

        # HACK Without this config file you get "No pinentry program" on 20.03.
        #      programs.gnupg.agent.pinentryFlavor doesn't appear to work, and this
        #      is cleaner than overriding the systemd unit.
        home.configFile."gnupg/gpg-agent.conf" = {
          text = ''
            default-cache-ttl ${toString cfg.cacheTTL}
            pinentry-program ${pkgs.pinentry.gtk2}/bin/pinentry
          '';
        };
      })

      (mkIf cfg.gitIntegration.enable {
        home.programs.git.signing = {
          # Setup gnupg key and stuff
          gpgPath = "${pkgs.gnupg}/bin/gpg2";
          inherit (cfg.gitIntegration) key;
          signByDefault = true;
        };
      })
    ];
}
