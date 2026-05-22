{
    pkgs,
    config,
    ...
}: {
    xdg.configFile."dunst/dunstrc".source = ./dunstrc;
}