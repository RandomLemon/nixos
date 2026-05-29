{ pkgs, config, ... }:
{
    imports = [
        ../waybar
    ];

    programs.alacritty.enable = true; # Super+T in the default setting (terminal)
    programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
    programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
    programs.waybar.enable = true; # launch on startup in the default setting (bar)
    services.mako.enable = true; # notification daemon
    services.swayidle.enable = true; # idle management daemon
    services.polkit-gnome.enable = true; # polkit
    home.packages = with pkgs; [
        swaybg # wallpaper
        xwayland-satellite # xwayland support
        wl-clipboard
        bibata-cursors
    ];

    xdg.configFile."niri/config.kdl".source = ./niri.kdl;
    xdg.configFile."niri/input.kdl".source = ./input.kdl;
    xdg.configFile."niri/output.kdl".source = ./output.kdl;
    xdg.configFile."niri/bind.kdl".source = ./bind.kdl;
    xdg.configFile."niri/layout.kdl".source = ./layout.kdl;
    xdg.configFile."niri/startup.kdl".source = ./startup.kdl;
    xdg.configFile."niri/windowrule.kdl".source = ./windowrule.kdl;
}