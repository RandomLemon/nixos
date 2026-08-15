{
  config,
  pkgs,
  lib,
  username,
  alien-pkgs,
  omp-pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./hardware
    ../../modules/hardware

    ../../modules/software/system/main.nix

    ../../modules/software/develop/direnv.nix
    ../../modules/software/develop/distrobox.nix
    ../../modules/software/develop/android-studio.nix

    ../../modules/software/game/minecraft.nix
    ../../modules/software/game/steam.nix

    ../../modules/software/desktop/greetd.nix
    ../../modules/software/desktop/niri.nix
  ];

  networking.hostName = "tx";

  # nix-ld
  programs.nix-ld.enable = true;

  environment.systemPackages = [
    # special environments
    alien-pkgs.nix-alien
    omp-pkgs.default
  ];

  # Steam — force AMD iGPU (Strix 880M/890M @ 1002:150e, PCI 65:00.0).
  # Proton/DXVK otherwise prefer the NVIDIA dGPU despite PRIME offload defaults.
  programs.steam = {
    package = pkgs.steam.override {
      extraEnv = {
        __GLX_VENDOR_LIBRARY_NAME = "mesa";
        DRI_PRIME = "pci-0000_65_00_0";
        MESA_VK_DEVICE_SELECT = "1002:150e!";
      };
    };
  };
}
