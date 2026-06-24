{ pkgs, ... }: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
    ];

    extraPackages = with pkgs; [
      nixd
      nil
      nixfmt
    ];

    userSettings = {
      load_direnv = "shell_hook";
      base_keymap = "VSCode";

      theme = {
        mode = "system";
        dark = "Ayu Dark";
        light = "Ayu Light";
      };

      terminal = {
        shell = {
          program = "zsh";
        };
        env = {
          TERM = "alacritty";
        };
      };

      languages = {
        Nix = {
          language_servers = [ "nixd" "nil" ];
        };
      };
    };
  };
}
