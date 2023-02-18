{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.hardware.graphics = with types; {
    enable =
      mkBoolOpt' (config.fht.desktop.xorg.enable)
      "Whether to enable graphics support.";
    nvidia = {
      enable = mkBoolOpt' false "Whether to enable Nvidia graphics support.";
      busId = mkOpt' str "" "Nvidia GPU bus ID";
    };
    intel = {
      enable = mkBoolOpt' false "Whether to enable Intel graphics support.";
      busId = mkOpt' str "" "Intel GPU bus ID";
    };
  };

  config = let
    cfg = config.fht.hardware.graphics;
  in (mkMerge [
    (mkIf cfg.enable {
      hardware.opengl = {
        # Enable opengl for video acceleration and decoding.
        enable = true;

        # Enable hardware acceleration even for 32-bit programs
        driSupport = true;
        driSupport32Bit = true;

        extraPackages = with pkgs; [libvdpau-va-gl vaapiVdpau];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          libvdpau-va-gl
          vaapiVdpau
        ];
      };

      # Allow our user to access the GPUs.
      user.extraGroups = ["video"];
    })

    (mkIf cfg.nvidia.enable {
      # Enable the nvidia driver ONLY! If you enable the intel one (which would be logic)
      # this would generate a broken xorg.conf since NixOS doesn't handle multiple GPUs
      # Refer to: https://github.com/NixOS/nixpkgs/issues/108018
      services.xserver.videoDrivers = ["nvidia"];

      # Disable the nouveau kernel driver since I'm using a *relatively* recent gpu
      boot.blacklistedKernelModules = ["nouveau"];

      # Add the prime-run script to $PATH
      environment.systemPackages = [
        (pkgs.writeScriptBin "prime-run" ''
          # Setup the environment to run the program using nvidia
          export __NV_PRIME_RENDER_OFFLOAD=1
          export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
          export __GLX_VENDOR_LIBRARY_NAME=nvidia
          export __VK_LAYER_NV_optimus=NVIDIA_only
          # Run the desired program with it's arguments
          exec "$@"
        '')
      ];

      # Nvidia video accel packages.
      hardware.opengl.extraPackages = [pkgs.nvidia-vaapi-driver];
      hardware.opengl.extraPackages32 = [pkgs.pkgsi686Linux.nvidia-vaapi-driver];

      # Setup nvidia prime and bus addresses.
      hardware.nvidia.prime = mkIf (cfg.nvidia.busId != "" && cfg.intel.busId != "") {
        offload.enable = true;
        intelBusId = cfg.intel.busId;
        nvidiaBusId = cfg.nvidia.busId;
      };

      # Setup the nvidia driver
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        # Required for the gpu to find the primary display
        modesetting.enable = true;
      };
    })

    (mkIf cfg.intel.enable {
      # Intel video accel packages.
      hardware.opengl.extraPackages = [pkgs.intel-media-driver];
      hardware.opengl.extraPackages32 = [pkgs.pkgsi686Linux.intel-media-driver];
    })
  ]);
}
