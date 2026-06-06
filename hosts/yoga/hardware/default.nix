{ lib, pkgs, ... }:
{
  imports = [
    ./x1e80100.nix
    ./el2.nix
  ];

  config = {
    nixpkgs.overlays = [
      (import ./packages/overlay.nix)
    ];
  };
}
