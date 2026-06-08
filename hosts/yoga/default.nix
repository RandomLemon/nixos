{ config, pkgs, lib, username, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware

    ../../modules/software/system/main.nix

    ../../modules/software/develop/direnv.nix
    ../../modules/software/develop/distrobox.nix

    ../../modules/software/desktop/greetd.nix
    ../../modules/software/desktop/niri.nix
  ];

  networking.hostName = "yoga";

  nixpkgs.hostPlatform.system = "aarch64-linux";

  hardware.lenovo-yoga-slim7x.enable = true;

  boot.loader.systemd-boot.configurationLimit = 2;

  boot.initrd.systemd = {
    enable = true;
    emergencyAccess = true;
  };

  boot.kernel.sysctl."kernel.sysrq" = 80;

  networking.networkmanager.plugins = lib.mkForce [ ];
}
