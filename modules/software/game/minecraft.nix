{ config, lib, pkgs, ... }:
{
  # Minecraft
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}