{
  pkgs,
  config,
  ...
}: {
  # xdg.configFile."kitty/kitty.conf".enable = false;

  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
  xdg.configFile."kitty/theme.conf".source = ./theme.conf;
}