{ pkgs, ... }:
{
  services.kanshi.enable = true;

  xdg.configFile."kanshi/config".source = ./config;
}
