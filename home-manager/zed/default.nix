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
      load_direnv = true;
      base_keymap = "VSCode";

      theme = {
        mode = "system";
      };

      terminal = {
        shell = {
          program = "zsh";
        };
        env = {
          TERM = "alacritty";
        };
      };

      lsp = {
        Nix = {
          language_servers = [ "nixd" "nil" ];
        };
      };
    };
  };
}
