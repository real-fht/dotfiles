{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.services.picom = {
    enable =
      mkBoolOpt' (config.fht.desktop.windowManagers.awesomewm.enable)
      "Whether to enable compositing via Picom. (dccsillag fork)";
  };

  config = let
    cfg = config.fht.services.picom;
  in
    mkIf cfg.enable {
      home.services.picom = let
        # class_is = c: "class_g = '${c}'";
        type_is = t: "window_type = '${t}'";
      in {
        enable = true;
        # package = pkgs.fht.picom-dccsillag;
        package = pkgs.picom-next;

        # General performance tuning.
        backend = "glx"; # better on intel igpus
        settings.glx-no-stencil = false;
        settings.experimental-backends = true;
        settings.use-damage = true;
        vSync = true;

        # Shadow settings.
        shadow = true;
        shadowExclude = [];
        shadowOffsets = [(-12) (-12)];
        shadowOpacity = 0.75;
        settings.shadow-radius = 12;
        settings.clip-shadow-above = [(type_is "dock")];
        settings.xinerama-shadow-crop = true;
        settings.shadow-exclude = [(type_is "splash-ignore")];

        # Fading settings.
        fade = true;
        fadeDelta = 4;

        # Opactiy settings.
        activeOpacity = 1.0;
        inactiveOpacity = 1.0;
        settings.frame-opacity = 1.0;
        settings.inactive-dim = 5.0e-3;

        # Corners.
        settings.corner-radius = 8;
        settings.transparent-clipping = false;
        settings.rounded-corners-exclude = [(type_is "dock")];

        # Background blurring.
        settings.blur-method = "dual_kawase";
        settings.blur-strength = 5;
        settings.blur-background = true;
        settings.blur-background-frame = true;
        settings.blur-background-fixed = false;
        settings.blur-background-exclude = [];

        # Custom fork for better animations.
        # settings.animations = true;
        # settings.animation-force-steps = false;
        # settings.animation-delta = 10;
        # settings.animation-clamping = true;
        # settings.animation-stiffness = 200.0;
        # settings.animation-dampening = 25.0;
        # settings.animation-window-mass = 1.0;
        # settings.animation-for-open-window = "zoom";
        # settings.animation-for-unmap-window = "zoom";
        # settings.animation-for-workspace-switch-in = "none";
        # settings.animation-for-workspace-switch-out = "none";
      };
    };
}
