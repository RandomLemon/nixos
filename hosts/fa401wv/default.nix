{ config, pkgs, lib, username, alien-pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hardware
    ../../modules/hardware

    ../../modules/software/system/main.nix

    ../../modules/software/develop/direnv.nix
    ../../modules/software/develop/distrobox.nix

    ../../modules/software/game/minecraft.nix
    ../../modules/software/game/steam.nix

    ../../modules/software/desktop/greetd.nix
    ../../modules/software/desktop/hyprland.nix
    ../../modules/software/desktop/niri.nix
  ];

  # nix-ld
  programs.nix-ld.enable = true;

  # special environments
  environment.systemPackages = [
      alien-pkgs.nix-alien
      pkgs.wemeet
  ];
}
