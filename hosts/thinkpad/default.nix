{ config, pkgs, lib, username, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware

    ../../modules/software/system/main.nix

    ../../modules/software/develop/direnv.nix

    ../../modules/software/desktop/greetd.nix
    ../../modules/software/desktop/hyprland.nix
  ];
  networking.hostName = "thinkpad";

  # Use Grub and MBR Legacy Bootloader
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
}
