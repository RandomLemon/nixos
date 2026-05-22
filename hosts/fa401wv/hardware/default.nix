{ config, lib, pkgs, ... }:

{
  imports = 
    [
      ./asus.nix
      ./nvidia.nix
    ];
    
  networking.hostName = lib.mkForce "tx";

  # Kernel
  # boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos;

  # AMD CPU
  boot = {
    blacklistedKernelModules = [ "nouveau" ];
    kernelParams = lib.mkDefault [
      ''pcie_aspm.policy=powersupersave''
      ''acpi_osi="Windows 2022"''
    ];
  };
  powerManagement.enable = true;
  # powerManagement.powertop.enable = true;
  # services.auto-epp.enable = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      energy_performance_preference = "power";
      platform_profile = "low-power";
      scaling_max_freq = "3800000"; # Max freq 3.8GHz
      turbo = "auto";
      # Battery charging
      enable_thresholds = "true"; 
      start_threshold = "50";
      stop_threshold = "60";
    };
    charger = {
      governor = "powersave";
      energy_performance_preference = "balance_performance";
      platform_profile = "balanced";
      turbo = "auto";
    };
  };

  # SSD
  services.fstrim.enable = lib.mkDefault true;

  # ACPI S3 Fix for FA401WV BIOS Version 319
  # Not Succeeded Yet...
  # boot.initrd.prepend = [
  #   "${(pkgs.callPackage ./custom-dsdt.nix {})}/dsdt.cpio"
  # ];

  # IIO Sensors
  hardware.sensor.iio.enable = lib.mkDefault true;

  # TMP Config for Moneta GPU fuzzing test
  specialisation = {
    nvidia-vfio.configuration = {
      system.nixos.tags = [ "nvidia-vfio" ];
      
      # boot.kernelPackages = let
      #   linux_moneta_pkg = { fetchurl, buildLinux, ... } @ args:

      #     buildLinux (args // rec {
      #       version = "6.18.2";
      #       modDirVersion = version;

      #       src = fetchurl {
      #         url = "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.18.2.tar.xz";
      #         # After the first build attempt, look for "hash mismatch" and then 2 lines below at the "got:" line.
      #         # Use "sha256-....." value here.
      #         hash = "sha256-VYxrurdJSSs0+Zgn/oB7ADmnRGk8IdOn4Ds6SO2quWo=";
      #       };
      #       kernelPatches = [
      #         {
      #           name = "moneta";
      #           patch = ./moneta.patch;
      #           structuredExtraConfig = {
      #             KVM_AGAMOTTO = lib.kernel.yes;
      #           };
      #         }
      #       ];

      #       extraConfig = ''
      #       '';

      #       extraMeta.branch = "6.18";
      #     } // (args.argsOverride or {}));
      #   linux_moneta = pkgs.callPackage linux_moneta_pkg{};
      # in 
      #   pkgs.lib.recurseIntoAttrs (pkgs.linuxPackagesFor linux_moneta);

      boot.initrd.kernelModules = [ 
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"

        "amdgpu" # replace or remove with your device's driver as needed
      ];
      boot.kernelParams = [
        "amd_iommu=on"
        "iommu=pt"
        "vfio-pci.ids=10de:28e0,10de:22be"
      ];
      boot.blacklistedKernelModules = lib.mkForce [ "nouveau" ];
    };
  };
}
