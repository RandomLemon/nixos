{ config, lib, pkgs, ... }:
{
  # Wayland Desktop Environment Configuations.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${config.programs.niri.package}/bin/niri-session";
  #       user = "myuser";
  #     };
  #   };
  # };

  systemd.user.services.niri.enableDefaultPath = false;
}