{ config, pkgs, lib, username, ... }:
let
  yogaUcmOverride = pkgs.writeText "LENOVO-83ED-YOGAAir14sQ8X9-LNVNB161216.conf" ''
    Syntax 4

    Include.slim7x.File "/Qualcomm/x1e80100/LENOVO-Slim-7x.conf"
  '';

  alsaUcm2 = pkgs.symlinkJoin {
    name = "alsa-ucm2-yoga";
    paths = [ pkgs.alsa-ucm-conf ];
    postBuild = ''
      install -Dm644 ${yogaUcmOverride} $out/share/alsa/ucm2/conf.d/x1e80100/LENOVO-83ED-YOGAAir14sQ8X9-LNVNB161216.conf
    '';
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware

    ../../modules/software/system/main.nix

    ../../modules/software/develop/direnv.nix
    ../../modules/software/develop/distrobox.nix

    ../../modules/software/desktop/greetd.nix
    ../../modules/software/desktop/niri.nix

    ../../modules/software/game/minecraft.nix
    ../../modules/software/game/waydroid.nix
  ];

  networking.hostName = "yoga";

  nixpkgs.hostPlatform.system = "aarch64-linux";

  hardware.lenovo-yoga-slim7x.enable = true;

  # Card long name does not match x1e80100.conf DMI regex ("Yoga Slim 7" vs
  # product_family "YOGA Air 14s Q8X9"). Merge override into the full UCM2 tree.
  environment.etc."alsa/ucm2".source = lib.mkForce "${alsaUcm2}/share/alsa/ucm2";

  # NixOS alsa-lib does not pick up /etc/alsa/ucm2 on its own; PipeWire ACP
  # needs this to load the Yoga profile instead of falling back to null sink.
  environment.sessionVariables.ALSA_CONFIG_UCM2 = "/etc/alsa/ucm2";
  systemd.user.services.pipewire.environment.ALSA_CONFIG_UCM2 = "/etc/alsa/ucm2";
  systemd.user.services.pipewire-pulse.environment.ALSA_CONFIG_UCM2 = "/etc/alsa/ucm2";
  systemd.user.services.wireplumber.environment.ALSA_CONFIG_UCM2 = "/etc/alsa/ucm2";

  boot.loader.systemd-boot.configurationLimit = 4;

  boot.initrd.systemd = {
    enable = true;
    emergencyAccess = true;
  };

  boot.kernel.sysctl."kernel.sysrq" = 80;

  networking.networkmanager.plugins = lib.mkForce [ ];

  # Default: x1e-nixos-config 6.19 kernel via hardware.lenovo-yoga-slim7x.enable.
  # Boot entry "ubuntu-concept" uses the Ubuntu Concept 7.1.y qcom-x1e kernel instead.
  specialisation = {
    ubuntu-concept.configuration = {
      system.nixos.tags = [ "ubuntu-concept" ];
      boot.kernelPackages = lib.mkForce (
        pkgs.callPackage ./kernel/ubuntu-concept.nix { }
      );
    };
  };
}
