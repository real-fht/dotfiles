{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.hardware.sound = {
    enable =
      mkBoolOpt' (config.fht.desktop.xorg.enable)
      "Whether to enable sound support using PipeWire.";
    alsa.enable =
      mkBoolOpt' (config.fht.hardware.sound.enable)
      "Whether to enable ALSA sound emulation.";
    bluetooth.enable =
      mkBoolOpt' false "Whether to enable sound via Bluetooth.";
    jack.enable = mkBoolOpt' false "Whether to enable Jack sound emulation.";
    pulseaudio.enable =
      mkBoolOpt' (config.fht.hardware.sound.enable)
      "Whether to enable PulseAudio sound emulation.";
  };

  config = let
    cfg = config.fht.hardware.sound;
  in
    mkMerge [
      (mkIf cfg.enable {
        # Required dependency for pipewire wireplumber to work.
        security.rtkit.enable = true;
        # -*-
        services.pipewire = {
          enable = true;
          audio.enable = true; # use pw as the main audio server
          # Use wireplumber instead of pipewire-media-session
          media-session.enable = false;
          wireplumber.enable = true;
        };

        # Allow our user to access sound cards.
        user.extraGroups = ["audio"];
      })

      (mkIf cfg.alsa.enable {
        # Enable alsa audio server emulation
        services.pipewire.alsa = mkIf cfg.alsa.enable {
          enable = true;
          support32Bit = true;
        };
      })

      (mkIf (cfg.bluetooth.enable && config.fht.hardware.bluetooth.enable) {
        # Enable bluetooth support for wireplumber.
        # To be more exact, to support bluetooth sound adjusment, and bluetooth codecs
        environment.etc."wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
          bluez_monitor.properties = {
          			["bluez5.enable-sbc-xq"] = true,
          			["bluez5.enable-msbc"] = true,
          			["bluez5.enable-hw-volume"] = true,
          			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
          };
        '';
      })

      # Enable pulseaudio audio sever emulation
      (mkIf cfg.pulseaudio.enable {
        services.pipewire.pulse.enable = true;
        # Required to install these packages to access pactl and pulsemixer packages.
        user.packages = with pkgs; [pulsemixer pulseaudio];
      })

      # Enable jack2 server emulation
      (mkIf cfg.jack.enable {services.pipewire.jack.enable = true;})
    ];
}
