{
  pkgs,
  lib,
  username,
  ...
}:
{
  home.packages = with pkgs; [
    firefox-esr
    chromium
    # (vscode.override { commandLineArgs = "--enable-wayland-ime %F"; })
    seafile-client
    qq
    v2ray
    v2raya
    libreoffice-qt6-fresh
    vlc
    localsend

    # wechat
    wemeet
    # (pkgs.callPackage ../modules/software/3rd/easierconnect/easierconnect.nix { })
  ];

  # Fix QQ under wayland
  xdg.desktopEntries.qq = {
    name = "QQ";
    genericName = "Instant Messaging";
    exec = "${pkgs.qq}/bin/qq --ozone-platform=wayland --enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --enable-wayland-ime=true --wayland-text-input-version=3 %U";
    terminal = false;
    categories = [ "Network" "InstantMessaging" ];
    icon = "qq";
    comment = "QQ for Linux";
  };

  # Default Applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # https://wiki.nixos.org/wiki/Default_applications

      "inode/directory" = "org.kde.dolphin.desktop";
      "x-scheme-handler/file" = "org.kde.dolphin.desktop";
      "application/zip" = "org.kde.ark.desktop";

      "text/plain" = [
        "org.kde.kate.desktop"
        "code.desktop"
      ];
      "image/x-mng" = "org.kde.gwenview.desktop";
      "application/pdf" = "firefox-esr.desktop";

      "text/html" = "firefox-esr.desktop";
      "x-scheme-handler/http" = "firefox-esr.desktop";
      "x-scheme-handler/https" = "firefox-esr.desktop";
      "x-scheme-handler/about" = "firefox-esr.desktop";
      "x-scheme-handler/unknown" = "firefox-esr.desktop";
    };
  };
}
