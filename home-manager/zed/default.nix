{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    mutableUserSettings = false;

    extraPackages = with pkgs; [
      nixd
      nil
      nixfmt
    ];
  };

  xdg.configFile."zed/settings.json".source = ./settings.json;
}
