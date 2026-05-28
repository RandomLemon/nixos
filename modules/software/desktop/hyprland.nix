{ config, lib, pkgs, ... }:

{
  # Dolphin fix
  nixpkgs.overlays = [
    (import ./dolphin-fix.nix)
  ];

  # Wayland Desktop Environment Configuations.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # services.xserver = {
  #   enable = true;
  #   # displayManager.gdm.enable = true;
  # };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kitty
  ];

  # Gnome fix
  # services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Nautilus fix
  # services.gvfs.enable = true;

  # Avoid suspend on power
  # services.logind.extraConfig = ''
  #   HandleLidSwitch=suspend
  #   HandleLidSwitchExternalPower=ignore
  # '';
}
