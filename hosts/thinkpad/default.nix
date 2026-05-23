{ config, pkgs, lib, username, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware

    ../../modules/software/system/main.nix
    ../../modules/software/system/secure.nix

    ../../modules/software/develop/direnv.nix

    ../../modules/software/desktop/hyprland.nix
  ];
  networking.hostName = "thinkpad";

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
}
