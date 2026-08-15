{ pkgs, config, ... }:
{
  imports = [
    ../../alacritty
    ../kanshi
    ../mako
    ../wallpaper
    ../swaylock
    ../swayidle
    ../waybar
    ../wofi
    ../wlogout
  ];
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  programs.waybar.enable = true; # launch on startup in the default setting (bar)
  services.polkit-gnome.enable = true; # polkit
  home.packages = with pkgs; [
    swaybg # wallpaper
    xwayland-satellite # xwayland support
    wl-clipboard
    bibata-cursors

    networkmanagerapplet
    brightnessctl
  ];

  xdg.configFile."niri/config.kdl".source = ./config/niri.kdl;
  xdg.configFile."niri/input.kdl".source = ./config/input.kdl;
  xdg.configFile."niri/output.kdl".source = ./config/output.kdl;
  xdg.configFile."niri/bind.kdl".source = ./config/bind.kdl;
  xdg.configFile."niri/layout.kdl".source = ./config/layout.kdl;
  xdg.configFile."niri/startup.kdl".source = ./config/startup.kdl;
  xdg.configFile."niri/wallpaper.kdl".source = ./config/wallpaper.kdl;
  xdg.configFile."niri/windowrule.kdl".source = ./config/windowrule.kdl;
  xdg.configFile."niri/misc.kdl".source = ./config/misc.kdl;
  xdg.configFile."niri/workspace.kdl".source = ./config/workspace.kdl;
}
