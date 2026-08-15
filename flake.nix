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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    omp-nix.url = "github:yuxqiu/omp-nix";
    omp-nix.inputs.nixpkgs.follows = "nixpkgs";
    # nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release"; # for cachyos kernel
    x1e-nixos-config.url = "github:kuruczgy/x1e-nixos-config";
    x1e-nixos-config.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-alien,
      omp-nix,
      # nix-cachyos-kernel,
      x1e-nixos-config,
      ...
    }@inputs:
    let
      username = "int16";

      mkHost =
        {
          system,
          hostModule,
          homeModules ? [ ],
          extraSpecialArgs ? { },
          extraModules ? [ ],
        }:
        let
          specialArgs = {
            inherit
              self
              username
              system
              inputs
              ;
          }
          // extraSpecialArgs;
        in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            { nix.settings.trusted-users = [ username ]; }
            hostModule
          ]
          ++ (
            if homeModules != [ ] then
              [
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.backupFileExtension = "hm.bak";
                  home-manager.extraSpecialArgs = inputs // specialArgs;
                  home-manager.users.${username} = {
                    imports = homeModules;
                  };
                }
              ]
            else
              [ ]
          )
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        tx = mkHost {
          system = "x86_64-linux";
          hostModule = ./hosts/fa401wv;
          homeModules = [ ./hm-profile/niri-desktop.nix ];
          extraSpecialArgs = {
            alien-pkgs = nix-alien.packages.x86_64-linux;
            omp-pkgs = omp-nix.packages.x86_64-linux;
          };
        };

        itx = mkHost {
          system = "x86_64-linux";
          hostModule = ./hosts/itx;
          homeModules = [ ./hm-profile/niri-desktop.nix ];
          extraSpecialArgs = {
            alien-pkgs = nix-alien.packages.x86_64-linux;
          };
        };

        thinkpad = mkHost {
          system = "x86_64-linux";
          hostModule = ./hosts/thinkpad;
          homeModules = [
            ./hm-profile/niri-desktop.nix
            ./hosts/thinkpad/home.nix
          ];
        };

        msr1 = mkHost {
          system = "aarch64-linux";
          hostModule = ./hosts/msr1;
        };

        yoga = mkHost {
          system = "aarch64-linux";
          hostModule = ./hosts/yoga;
          homeModules = [ ./hm-profile/niri-desktop.nix ];
          extraModules = [
            x1e-nixos-config.nixosModules.x1e
          ];
        };
      };
    };
}
