{ pkgs, ... }:
{
  xdg.desktopEntries.code.exec = ''
    export VK_DRIVER_FILES=/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json
    export VK_ICD_FILENAMES=$VK_DRIVER_FILES
    exec ${pkgs.vscode.fhs}/bin/code "$@"
'';

  home.packages = with pkgs; [
    telegram-desktop
  ];
}