{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    mutableUserSettings = false;

    extraPackages = with pkgs; [
      nixd
      nixfmt
      opencode
      gopls
    ];
  };

  xdg.configFile."zed/settings.json".source = ./settings.json;
  xdg.configFile."zed/keymap.json".source = ./keymap.json;
}
