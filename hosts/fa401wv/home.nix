{ pkgs, ... }:
{
  xdg.desktopEntries.code = {
    name = "Visual Studio Code";
    genericName = "Text Editor";
    exec = ''
      env VK_DRIVER_FILES=/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json VK_ICD_FILENAMES=/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json ${pkgs.vscode.fhs}/bin/code %U
    '';
    terminal = false;
    categories = [ "Utility" "TextEditor" "Development" "IDE" ];
    icon = "vscode";
    comment = "Code Editing. Redefined.";
  };

  home.packages = with pkgs; [
    telegram-desktop
  ];
}