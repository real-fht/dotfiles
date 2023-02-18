{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.services.redshift = with types; {
    enable = mkBoolOpt' false "Whether to enable the redshift service.";
    dawmTime = mkOpt' str "5:30-8:00" "Your current region dawn time.";
    duskTime = mkOpt' str "20:30-00:00" "Your current region dusk time.";
  };

  config = let
    cfg = config.fht.services.redshift;
  in
    mkIf cfg.enable {
      home.services.redshift = {
        # inherit (cfg) dawnTime duskTime;
        enable = true;
        provider = "geoclue2";
      };
    };
}
