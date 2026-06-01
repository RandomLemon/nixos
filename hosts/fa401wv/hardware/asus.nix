{ config, lib, pkgs, ...}:

{
  # ASUS
  # services.supergfxd.enable = true; # Deprecated!
  services = {
    asusd = {
      enable = true;
      # enableUserService = true;
    };
  };
}
