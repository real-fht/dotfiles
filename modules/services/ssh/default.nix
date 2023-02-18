{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.services.ssh = {
    enable = mkBoolOpt' true "Whether to enable the OpenSSH daemon";
  };

  config = let
    cfg = config.fht.services.ssh;
  in
    mkIf cfg.enable {
      # Enable the openssh daemon at the system level.
      services.openssh = {
        enable = true;
        banner = ''
          Welcome to @${config.networking.hostName}!
          This is probably the messiest sytem you'll ever ssh into.
        '';

        # Some basic security and prevent settings.
        settings = {
          PasswordAuthentication = false; # rather use SSH keypairs.
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "without-password"; # seriously, nobody wants this.
          X11Forwarding = false;
        };
      };
    };
}
