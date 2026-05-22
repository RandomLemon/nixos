{ config, lib, pkgs, ...}:

{
  # ASUS
  services.supergfxd.enable = true;
  services = {
    asusd = {
      enable = true;
      # enableUserService = true;
    };
  };
}
