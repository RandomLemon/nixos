{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware

    ../../modules/software/system/main.nix

    ../../modules/software/develop/direnv.nix

    ../../modules/software/desktop/greetd.nix
    ../../modules/software/desktop/niri.nix
  ];
  networking.hostName = "thinkpad";

  # Use Grub and MBR Legacy Bootloader
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.intel-gpu-tools.enable = true;   # 核显调频/调试
  services.thermald.enable = true;          # Ivy Bridge 温控守护

  services.tlp = {
    enable = true;
    settings = {
      # CPU 调速：插电性能，电池省电
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 95;

      PCIE_ASPM_ON_AC = "powersave";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # 磁盘、声卡、WiFi 省电
      SATA_LINKPWR_ON_BAT = "min_power";
      SOUND_POWER_SAVE_ON_BAT = 1;
      WIFI_PWR_ON_BAT = 1;

      # 电池保养：40–80 阈值
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 90;

      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;
    };
  };

  services.thinkfan.enable = true;
  boot.kernelParams = [
    "i915.enable_rc6=1"        # 核显渲染电源管理
    "i915.enable_fbc=1"        # 帧缓冲压缩
    "pcie_aspm=force"          # 强制 PCIe 链路省电
    "quiet"
    "thinkpad_acpi.fan_control=1"
  ];
}
