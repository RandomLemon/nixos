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
      model = "opencode-go/deepseek-v4-flash";
      provider = {
        opencode-go = {
          models = {
            "deepseek-v4-flash" = {
              options = {
                reasoningEffort = "high";
                reasoningSummary = "auto";
              };
            };
          };
        };
      };
    };

    tui = {
      theme = "system";
    };
  };
}
