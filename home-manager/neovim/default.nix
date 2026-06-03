{ pkgs, ... }:
let
  vimPlugins = pkgs.vimPlugins;

  plugins = with vimPlugins; [
    # UI
    adwaita-nvim
    nvim-web-devicons
    indent-blankline-nvim
    lualine-nvim

    # Git
    gitsigns-nvim

    # Editor
    which-key-nvim
    (nvim-treesitter.withAllGrammars)
    vim-commentary

    # Telescope
    plenary-nvim
    telescope-fzf-native-nvim
    telescope-nvim

    # LSP & completion
    nvim-lspconfig
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp_luasnip
    friendly-snippets
    luasnip
    lspkind-nvim
    nvim-cmp
    nvim-autopairs
  ];

  lspTools = with pkgs; [
    lua-language-server
    nixd
    alejandra
    stylua
    tree-sitter
    bash-language-server
    yaml-language-server
    vscode-json-languageserver
    rust-analyzer
  ];
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withRuby = false;

    extraPackages = lspTools;

    plugins = map (plugin: { inherit plugin; }) plugins;

    initLua = ''
      require("options")
      require("keymaps")
      require("plugins")
    '';
  };

  xdg.configFile."nvim/lua".source = ./lua;
}
