{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    mutableUserSettings = false;

    extraPackages = with pkgs; [
      nixd
      nil
      nixfmt
      opencode
    ];
  };

  xdg.configFile."zed/settings.json".source = ./settings.json;
  xdg.configFile."zed/keymap.json".source = ./keymap.json;
}
