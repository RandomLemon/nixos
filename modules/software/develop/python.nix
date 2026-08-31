{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    uv
  ];
  programs.nix-ld.enable = lib.mkDefault true;
}
