{ config, lib, pkgs, ... }:

{
  # NVIDIA fxxk U
  services.xserver.videoDrivers = lib.mkForce ["amdgpu" "nvidia"];
  hardware = {
    graphics = { 
      enable = true;
      enable32Bit = true;
    };
    ## Enable the Nvidia card, as well as Prime and Offload:
    amdgpu.initrd.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      # package below is from https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "590.48.01";
      #   sha256_64bit = "sha256-ueL4BpN4FDHMh/TNKRCeEz3Oy1ClDWto1LO/LWlr1ok=";
      #   sha256_aarch64 = "sha256-FOz7f6pW1NGM2f74kbP6LbNijxKj5ZtZ08bm0aC+/YA=";
      #   openSha256 = "sha256-hECHfguzwduEfPo5pCDjWE/MjtRDhINVr4b1awFdP44=";
      #   settingsSha256 = "sha256-NWsqUciPa4f1ZX6f0By3yScz3pqKJV1ei9GvOF8qIEE=";
      #   persistencedSha256 = "sha256-wsNeuw7IaY6Qc/i/AzT/4N82lPjkwfrhxidKWUtcwW8=";
      # };
      open = true;
      modesetting.enable = true;
      nvidiaSettings = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:101:0:0";
        nvidiaBusId = "PCI:100:0:0";
      };  

      powerManagement = {
        enable = true;
        finegrained = true;
      };

      dynamicBoost.enable = true;
    };
  };

  # MultiGPU
  environment.sessionVariables = {
    __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json";
    WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    __GLX_VENDOR_LIBRARY_NAME = "mesa";
  };
}
