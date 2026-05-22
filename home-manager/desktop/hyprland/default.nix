{ pkgs, config, ... }:
{
  imports = [
    ../dunst
    ../kitty
    ../waybar
    ../wlogout
    ../wofi

    ./applications.nix
  ];

  services.hyprpolkitagent.enable = true;
  # services.hyprlauncher.enable = true;
  services.clipman.enable = true;

  # xdg.configFile."hypr/hyprland.conf".enable = false;
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./hypridle.conf;
  xdg.configFile."hypr/wallpaper/wallpaper.jpg".source = ./wallpaper/wallpaper.jpg;
}