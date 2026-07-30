{ pkgs, ... }:
{
  home.packages = with pkgs; [
    feather
    wine
    winetricks
    protontricks

    telegram-desktop
  ];
}
