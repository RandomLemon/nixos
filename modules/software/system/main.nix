{ config, lib, pkgs, username, ... }:

{
  # Unfree software
  nixpkgs.config.allowUnfree = true;

  # User
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # git
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ zsh ];

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.substituters = lib.mkForce [
    "https://mirrors.cernet.edu.cn/nix-channels/store?priority=10"
    "https://mirror.nju.edu.cn/nix-channels/store?priority=50"
    "https://mirrors.ustc.edu.cn/nix-channels/store?priority=50"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=50"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;

  system.stateVersion = "25.05";

  # Utils
  environment.systemPackages = with pkgs; [
    nano
    vim
    htop
    btop
    tree
    curl
    wget
    fastfetch
    s-tui
    unzip
    zip
    unar
    ntfs3g
    toybox # Linux Utils
    pciutils
    usbutils
    nvtopPackages.full
    powertop
  ];

  # USB devices
  services.udisks2.enable = true;

  # 666
  services.v2raya.enable = true;
}
