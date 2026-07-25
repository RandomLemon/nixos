{
  config,
  lib,
  pkgs,
  ...
}:
{
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  # Enable clipboard sharing
  environment.systemPackages = [ pkgs.wl-clipboard ];
}
