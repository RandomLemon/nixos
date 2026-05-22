{ pkgs, config, ... }:
{
    home.packages = with pkgs; [
        # Utils
        networkmanagerapplet
        brightnessctl
        remmina
        kdePackages.gwenview # Image Viewer
        kdePackages.ark # Archive Manager
        kdePackages.dragon # Media Player
        kdePackages.kate # Text Editor

        # File Manager
        kdePackages.dolphin
        kdePackages.kio # needed since 25.11
        kdePackages.kio-fuse # to mount remote filesystems via FUSE
        kdePackages.kio-extras

        # Environment
        libsForQt5.qt5.qtwayland
        kdePackages.qtwayland
        xlsclients
        xwayland
        kdePackages.qtsvg

        # Hyprland
        hyprpicker
        hyprcursor
        hyprlock
        hypridle
        hyprpaper
        hyprshot
        hyprtoolkit
        wofi
        wlogout
        dunst
        hyprshade
        bibata-cursors

        wl-clipboard
    ];
}