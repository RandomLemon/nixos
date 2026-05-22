{ config, lib, pkgs, ... }:
{
  # mysql
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
}