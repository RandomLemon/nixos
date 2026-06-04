{ pkgs, lib, username, ... }: {
  # Visual Studio Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.packages = with pkgs; [
    code-cursor
  ];
}