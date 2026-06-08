{
  description = "Nix16 flake";

  nixConfig = {
    extra-substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release"; # for cachyos kernel
    x1e-nixos-config.url = "github:kuruczgy/x1e-nixos-config";
    x1e-nixos-config.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    # nixpkgs-stable,
    home-manager,
    # chaotic,
    nix-alien,
    nix-cachyos-kernel,
    x1e-nixos-config,
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
        { nix.settings.trusted-users = [ username ]; }
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
        # extraModules = [
        #   # chaotic.nixosModules.default # for cachyos kernel
        #   ({ pkgs, ... }: {
        #     nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
        #     boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;
        #   })
        # ];
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

      yoga = mkHost {
        system = "aarch64-linux";
        hostModule = ./hosts/yoga;
        homeModule = ./hosts/fa401wv/home.nix;
        extraModules = [
          x1e-nixos-config.nixosModules.x1e
        ];
      };
    };
  };
}
