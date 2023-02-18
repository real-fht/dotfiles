{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.hardware.input = with types; {
    keyboardLayout = mkOpt' str "us" "The keyboard layout to use.";
  };

  config = let
    cfg = config.fht.hardware.input;
  in
    mkMerge [
      {
        # Set our keyboard layout.
        console.keyMap = cfg.keyboardLayout;
        services.xserver.layout = cfg.keyboardLayout;
      }
    ];
}
