# Ubuntu Concept linux-qcom-x1e 7.0 kernel (qcom-x1e-7.0 branch).
# Source: https://code.launchpad.net/~ubuntu-concept/ubuntu/+source/linux/+git/resolute
{
  lib,
  fetchgit,
  buildLinux,
  callPackage,
  linuxPackagesFor,
  ...
}:

let
  linuxUbuntuConceptPkg =
    { ... } @ args:
    buildLinux (
      args
      // rec {
        pname = "linux";
        version = "7.0.0";
        modDirVersion = "7.0.0";

        src = fetchgit {
          url = "https://git.launchpad.net/~ubuntu-concept/ubuntu/+source/linux/+git/resolute";
          rev = "d997b73be317eed5dd6e617028769fb48addc3db"; # qcom-x1e-7.0 @ 7.0.0-22.22
          hash = "sha256-wTHhj7UuY6TJSiq0FcbGzH+x4UbQdtiOKPBAmupkn5A=";
        };

        # Matches debian.qcom-x1e/rules.d/arm64.mk (defconfig = defconfig).
        defconfig = "defconfig";
        ignoreConfigErrors = true;
        extraMeta.branch = "7.0";

        structuredExtraConfig = with lib.kernel; {
          VIRTUALIZATION = yes;
          KVM = yes;
          MAGIC_SYSRQ = yes;
          EC_LENOVO_YOGA_SLIM7X = module;

          # Trim unrelated platforms to reduce build time (from x1e-nixos-config).
          ACPI = no;
          HOTPLUG_PCI = no;

          ARCH_ACTIONS = no;
          ARCH_AIROHA = no;
          ARCH_SUNXI = no;
          ARCH_ALPINE = no;
          ARCH_APPLE = no;
          ARCH_AXIADO = no;
          ARCH_BCM = no;
          ARCH_BCM2835 = no;
          ARCH_BCM_IPROC = no;
          ARCH_BCMBCA = no;
          ARCH_BRCMSTB = no;
          ARCH_BERLIN = no;
          ARCH_BLAIZE = no;
          ARCH_CIX = no;
          ARCH_EXYNOS = no;
          ARCH_SPARX5 = no;
          ARCH_K3 = no;
          ARCH_LG1K = no;
          ARCH_HISI = no;
          ARCH_KEEMBAY = no;
          ARCH_MEDIATEK = no;
          ARCH_MESON = no;
          ARCH_MVEBU = no;
          ARCH_NXP = no;
          ARCH_LAYERSCAPE = no;
          ARCH_MXC = no;
          ARCH_S32 = no;
          ARCH_MA35 = no;
          ARCH_NPCM = no;
          ARCH_REALTEK = no;
          ARCH_RENESAS = no;
          ARCH_ROCKCHIP = no;
          ARCH_SEATTLE = no;
          ARCH_INTEL_SOCFPGA = no;
          ARCH_SOPHGO = no;
          ARCH_STM32 = no;
          ARCH_SYNQUACER = no;
          ARCH_TEGRA = no;
          ARCH_TESLA_FSD = no;
          ARCH_SPRD = no;
          ARCH_THUNDER = no;
          ARCH_THUNDER2 = no;
          ARCH_UNIPHIER = no;
          ARCH_VEXPRESS = no;
          ARCH_VISCONTI = no;
          ARCH_XGENE = no;
          ARCH_ZYNQMP = no;

          DRM_NOUVEAU = no;
          DRM_ETNAVIV = no;
          DRM_HISI_HIBMC = no;
          DRM_HISI_KIRIN = no;
          DRM_LIMA = no;
          DRM_PANFROST = no;
          DRM_PANTHOR = no;
          DRM_TIDSS = no;
          DRM_POWERVR = no;

          WLAN_VENDOR_ADMTEK = no;
          WLAN_VENDOR_ATMEL = no;
          WLAN_VENDOR_BROADCOM = no;
          WLAN_VENDOR_INTEL = no;
          WLAN_VENDOR_INTERSIL = no;
          WLAN_VENDOR_MARVELL = no;
          WLAN_VENDOR_MEDIATEK = no;
          WLAN_VENDOR_MICROCHIP = no;
          WLAN_VENDOR_PURELIFI = no;
          WLAN_VENDOR_RALINK = no;
          WLAN_VENDOR_REALTEK = no;
          WLAN_VENDOR_RSI = no;
          WLAN_VENDOR_SILABS = no;
          WLAN_VENDOR_ST = no;
          WLAN_VENDOR_TI = no;
          WLAN_VENDOR_ZYDAS = no;
          WLAN_VENDOR_QUANTENNA = no;
          SND_DRIVERS = no;
          SND_PCI = no;
        };
      }
      // (args.argsOverride or { })
    );

  linuxUbuntuConcept = callPackage linuxUbuntuConceptPkg { };
in
lib.recurseIntoAttrs (linuxPackagesFor linuxUbuntuConcept)
