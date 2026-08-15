# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
  };
  # networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  boot.kernelPackages =
    let
      linux_msr1_pkg =
        { fetchurl, buildLinux, ... }@args:
        buildLinux (
          args
          // rec {
            version = "7.0.1-msr1";
            modDirVersion = "7.0.1";

            #stdenv = pkgs.gcc13Stdenv;

            src = fetchurl {
              url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.0.1.tar.xz";
              hash = "sha256-ssk1o20kmA4R5ZvtPKVY6m1nYZ7ABl+qM1zcC2TYh78=";
            };
            kernelPatches = [
              {
                name = "msr1";
                patch = ./msr1-7.0.1.patch;
              }
            ];

            # configfile = ./config-msr1-7.0.1;
            extraMeta.branch = "7.0";
            ignoreConfigErrors = true;
            extraConfig = ''
              ARCH_CIX y
              PCI_SKY1 y
              PCIE_CADENCE_HOST y
              PINCTRL_SKY1_BASE y
              PINCTRL_SKY1 y
              RESET_SKY1 y
              RESET_SKY1_AUDSS y
              CIX_MBOX y
              CLK_SKY1_AUDSS y
              CLK_SKY1_ACPI y
              CIX_ACPI_RESOURCE_LOOKUP y
              HWSPINLOCK_SKY1 y
              NVMEM_SKY1 y
              CIX_SKY1_SOCINFO y
              SKY1_PDC y
              CIX_BUS_PERF y
              CIX_CPU_IPA y
              CIX_DDR_LP y
              GPIO_CADENCE y
              PWM_SKY1 y
              SKY1_WATCHDOG y
              SKY1_GPT_TIMER y
              SENSORS_CIX_FAN m

              DRM_CIX m
              DRM_LINLONDP m
              DRM_TRILIN_DPSUB m
              DRM_TRILIN_DP_CIX m
              DRM_CIX_VIRTUAL m
              DRM_CIX_EDP_PANEL m
              DRM_PANTHOR m
              FIRMWARE_EDID y
              DRM_DISPLAY_DP_AUX_CEC y

              SND_HDA_CIX_IPBLOQ m
              SND_SOC_CIX m
              SND_SOC_SKY1_SOUND_CARD m
              SND_SOC_CDNS_I2S_MC m
              SND_SOC_CDNS_I2S_SC m
              SND_SOC_SOF_CIX_TOPLEVEL y
              SND_SOC_SOF_CIX_COMMON m
              SND_SOC_SOF_CIX_SKY1 m

              USB_CDNS_SUPPORT y
              USB_CDNS3 y
              USB_CDNSP y
              USB_CDNSP_SKY1 y
              CIX_ACPI_USB_SCAN y
              TYPEC y
              USB_UAS m
              PHY_CIX_USB2 y
              PHY_CIX_USB3 y
              PHY_CIX_USBDP y

              BLK_DEV_NVME y
              PHY_CIX_PCIE y
              XFS_FS m
              MD_RAID0 m
              MD_RAID1 m
              MD_RAID10 m
              MD_RAID456 m
              DM_THIN_PROVISIONING m
              DM_SNAPSHOT m
              CIFS m

              VIDEO_LINLON m
              VIDEO_LINLON_PRINT_FILE y

              CIX_DSP m
              CIX_DSP_RPROC m
              DMABUF_HEAPS_DSP m

              NETFILTER y
              NF_TABLES m
              IPV6 m
              NF_NAT m
              NFT_COMPAT m
              NFT_CT m
              NFT_COUNTER m
              NFT_FIB_IPV4 m
              NFT_FIB_IPV6 m
              NFT_LIMIT m
              NFT_LOG m
              NFT_NAT m
              NFT_REJECT m
              NETFILTER_XT_MATCH_LIMIT m
              NF_REJECT_IPV4 m
              NF_REJECT_IPV6 m
              IP6_NF_MATCH_RT m
              IP6_NF_MATCH_HL m
              IP6_NF_FILTER m
              IP6_NF_TARGET_REJECT m
              IP_NF_FILTER m
              IP_NF_TARGET_REJECT m
              NETFILTER_XT_MATCH_COMMENT m
              NETFILTER_XT_MATCH_MULTIPORT m
              NETFILTER_XT_MATCH_STATE m
              NETFILTER_XT_MATCH_MARK m
              NETFILTER_XT_MATCH_MAC m
              NETFILTER_XT_MATCH_OWNER m
              NETFILTER_XT_MATCH_RECENT m
              NETFILTER_XT_MATCH_HASHLIMIT m
              NETFILTER_XT_MATCH_HL m
              NETFILTER_XT_MATCH_TCPMSS m
              NETFILTER_XT_TARGET_MARK m
              NETFILTER_XT_TARGET_TCPMSS m
              NETFILTER_XT_TARGET_NFLOG m
              NETFILTER_XT_CONNMARK m
              NETFILTER_XT_MATCH_CONNMARK m
              NETFILTER_XT_TARGET_CONNMARK m
              NFT_MASQ m
              BONDING m
              DUMMY m
              VXLAN m
              WIREGUARD m
              GENEVE m
              IPVLAN m
              NF_CONNTRACK_FTP m
              NF_NAT_FTP m
              NET_SCH_FQ m
              NET_SCH_FQ_CODEL m
              TCP_CONG_BBR m
              CIFS_DFS_UPCALL y
              CIFS_UPCALL y
              CIFS_XATTR y
              NFS_V4_0 y

              CIX_ACPI_GPU_SCAN y

              SECURITY_APPARMOR y
              LSM "landlock,lockdown,yama,loadpin,safesetid,ipe,apparmor,bpf"

              CGROUP_NET_CLASSID y
              CGROUP_NET_PRIO y
              CHECKPOINT_RESTORE y
              BIG_KEYS y
              ENCRYPTED_KEYS m
              VHOST_NET m
              VHOST_VSOCK m
              PSI y
              SCHEDSTATS y
              TASK_DELAY_ACCT y
              KPROBES y
              ZRAM m
              ZSWAP y
              CRYPTO_USER_API_HASH m
              CRYPTO_USER_API_SKCIPHER m
              CRYPTO_USER_API_AEAD m

              NFT_REDIR m
              NETFILTER_XT_TARGET_MASQUERADE m
              NETFILTER_XT_TARGET_REDIRECT m
              NFT_FIB_INET m
              NET_ACT_CONNMARK m
              NET_ACT_CTINFO m

              DRM_VGEM n
              DRM_SKY1 m

              ARM64_VHE y
              BINFMT_MISC m
              BLK_DEV_THROTTLING y
              BT_L2CAP m
              BT_SCO m
              CFS_BANDWIDTH y
              CRYPTO_SEQIV m
              FIRMWARE_EDID y
              INET_ESP m
              IP6_NF_FILTER m
              IP6_NF_MANGLE m
              IP6_NF_NAT m
              IP6_NF_RAW m
              IP6_MF_TARGET_MASQUERADE m
              IP_NF_FILTER m
              IP_NF_MANGLE m
              IP_NF_NAT m
              IP_NF_RAW m
              IP_MF_TARGET_MASQUERADE m
              NETFILTER_XTABLES_COMPAT y
              NETFILTER_XTABLES_LEGACY y
              R8169 y
              SND_SEQ_DUMMY m
              SND_SEQUENCER m
              SND_USB_AUDIO m
              SUNRPC_BACKCHANNEL y
              UHID m
              XFRM_ALGO m
              XFRM_USER m
              XFRM y

              NVME_AUTH m
            '';

          }
          // (args.argsOverride or { })
        );
      linux_msr1 = pkgs.callPackage linux_msr1_pkg { };
    in
    pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_msr1);

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
