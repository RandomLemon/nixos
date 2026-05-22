{ config, lib, pkgs, ... }:
{
  # polkit
  security.polkit.enable = true;
  # Secure
  security.pam.services.login.enableGnomeKeyring = true;
}