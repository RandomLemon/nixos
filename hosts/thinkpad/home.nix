{ pkgs, lib, username, ... }:
{
  imports = [
    ../../home-manager/core.nix
    ../../home-manager/applications.nix
    ../../home-manager/zsh.nix
    ../../home-manager/code.nix

    ../../home-manager/desktop/niri
  ];

  home.packages = with pkgs; [
    feather
    wine
    winetricks
    protontricks

    telegram-desktop
  ];
}
