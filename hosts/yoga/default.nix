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

  boot.loader.systemd-boot.configurationLimit = 4;

  boot.initrd.systemd = {
    enable = true;
    emergencyAccess = true;
  };

  boot.kernel.sysctl."kernel.sysrq" = 80;

  networking.networkmanager.plugins = lib.mkForce [ ];

  # Default: x1e-nixos-config 6.19 kernel via hardware.lenovo-yoga-slim7x.enable.
  # Boot entry "ubuntu-concept" uses the Ubuntu Concept 7.0 qcom-x1e kernel instead.
  specialisation = {
    ubuntu-concept.configuration = {
      system.nixos.tags = [ "ubuntu-concept" ];
      boot.kernelPackages = lib.mkForce (
        pkgs.callPackage ./kernel/ubuntu-concept.nix { }
      );
    };
  };
}
