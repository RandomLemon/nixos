{ config, lib, pkgs, ... }:
{
  # distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = [ pkgs.distrobox ];
}