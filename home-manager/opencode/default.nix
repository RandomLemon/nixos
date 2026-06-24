{ pkgs, ... }:
{
  programs.opencode = {
    enable = true;

    extraPackages = with pkgs; [
      git
      ripgrep
      fd
      nixd
      nil
      nixfmt
    ];

    settings = {
      autoupdate = false;
    };

    tui = {
      theme = "system";
    };
  };
}
