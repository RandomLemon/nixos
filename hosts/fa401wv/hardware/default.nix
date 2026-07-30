{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./asus.nix
    ./nvidia.nix
    ./tlp.nix
  ];

  networking.hostName = lib.mkForce "tx";

  # Kernel
  # boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos;

  # AMD CPU
  boot = {
    blacklistedKernelModules = [ "nouveau" ];
    kernelParams = lib.mkDefault [
      "pcie_aspm.policy=powersupersave"
      # ''acpi_osi="Windows 2022"''
    ];
  };
  powerManagement.enable = true;
  # powerManagement.powertop.enable = true;
  # services.auto-epp.enable = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # SSD
  services.fstrim.enable = lib.mkDefault true;

  # IIO Sensors
  hardware.sensor.iio.enable = lib.mkDefault true;

  # TMP Config for GPU fuzzing test
  specialisation = {
    nvidia-vfio.configuration = {
      system.nixos.tags = [ "nvidia-vfio" ];

      ### Moneta Patch
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
