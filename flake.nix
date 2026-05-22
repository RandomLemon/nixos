{
  description = "Nix16 flake";

  nixConfig = {
    extra-substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirror.nju.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
      # "https://chaotic-nyx.cachix.org"
      # "https://attic.xuyh0120.win/lantian" # cachyos kernel, from https://github.com/xddxdd/nix-cachyos-kernel
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      # "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" # cachyos kernel
    ];
  };

  inputs = {
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # hyprland.url = "github:hyprwm/Hyprland";
    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # for cachyos kernel
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release"; # for cachyos kernel
  };

  outputs = {
    self,
    nixpkgs,
    # nixpkgs-stable,
    home-manager,
    # chaotic,
    nix-alien,
    nix-cachyos-kernel,
    ...
  }@inputs:
  let
    username = "int16";

    mkHost = {
      system,
      hostModule,
      homeModule ? null,
      extraSpecialArgs ? {},
      extraModules ? [],
    }:
    let
      specialArgs = { inherit self username system inputs; } // extraSpecialArgs;
    in
    nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = [
        hostModule
      ]
      ++ (if homeModule != null then [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm.bak";
          home-manager.extraSpecialArgs = inputs // specialArgs;
          home-manager.users.${username} = import homeModule;
        }
      ] else [])
      ++ extraModules;
    };
  in {
    nixosConfigurations = {
      tx = mkHost {
        system = "x86_64-linux";
        hostModule = ./hosts/fa401wv;
        homeModule = ./hosts/fa401wv/home.nix;
        extraSpecialArgs = {
          alien-pkgs = nix-alien.packages.x86_64-linux;
          # pkgs-stable = nixpkgs-stable.legacyPackages.x86_64-linux;
        };
        extraModules = [
          # chaotic.nixosModules.default # for cachyos kernel
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
            boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;
          })
        ];
      };

      thinkpad = mkHost {
        system = "x86_64-linux";
        hostModule = ./hosts/thinkpad;
        homeModule = ./hosts/thinkpad/home.nix;
      };

      msr1 = mkHost {
        system = "aarch64-linux";
        hostModule = ./hosts/msr1;
      };
    };
  };
}
