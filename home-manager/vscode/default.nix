{ pkgs, lib, username, ... }: {
  # Visual Studio Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}
