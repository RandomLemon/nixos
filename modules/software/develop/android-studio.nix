{ config, pkgs, username, ... }:

{
  # 1. 同意 Android SDK 许可，否则 nixos-rebuild 会直接失败
  nixpkgs.config.android_sdk.accept_license = true;

  # 2. 把 Android Studio 加入系统包
  environment.systemPackages = with pkgs; [
    android-studio
  ];

  # 3. 让当前用户能用 KVM 跑模拟器
  users.users.${username}.extraGroups = [ "kvm" ];

  # 4. （可选）adb/fastboot 的 udev 规则，接真机调试用
  # services.udev.packages = [ pkgs.android-udev-rules ];
}
