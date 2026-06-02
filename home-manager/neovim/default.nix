{ pkgs, ... }:
let
  inherit (pkgs.vimPlugins)
    adwaita-nvim
    cmp-buffer
    cmp-nvim-lsp
    cmp-path
    cmp_luasnip
    friendly-snippets
    gitsigns-nvim
    indent-blankline-nvim
    lspkind-nvim
    luasnip
    lualine-nvim
    nvim-autopairs
    nvim-cmp
    nvim-lspconfig
    nvim-web-devicons
    plenary-nvim
    telescope-fzf-native-nvim
    telescope-nvim
    vim-commentary
    which-key-nvim
    ;

  nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withRuby = false;

    extraPackages = with pkgs; [
      # LSP / formatters
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

    plugins = [
      { plugin = adwaita-nvim; }
      { plugin = nvim-web-devicons; }
      {
        plugin = indent-blankline-nvim;
        config = ''
          require("ibl").setup({
            indent = { char = "│" },
            scope = { enabled = false },
          })
        '';
        type = "lua";
      }
      {
        plugin = gitsigns-nvim;
        config = "require('gitsigns').setup()";
        type = "lua";
      }
      {
        plugin = which-key-nvim;
        config = "require('which-key').setup()";
        type = "lua";
      }
      {
        plugin = nvim-treesitter;
        config = ''
          require("nvim-treesitter").setup({
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = false,
          })
        '';
        type = "lua";
      }
      { plugin = plenary-nvim; }
      { plugin = telescope-fzf-native-nvim; }
      {
        plugin = telescope-nvim;
        config = ''
          require("telescope").load_extension("fzf")
          require("telescope").setup({
            defaults = {
              mappings = {
                i = {
                  ["<C-u>"] = false,
                  ["<C-d>"] = false,
                },
              },
            },
          })
        '';
        type = "lua";
      }
      {
        plugin = nvim-lspconfig;
        config = "require('lsp')";
        type = "lua";
      }
      { plugin = cmp-nvim-lsp; }
      { plugin = cmp-buffer; }
      { plugin = cmp-path; }
      { plugin = cmp_luasnip; }
      { plugin = friendly-snippets; }
      { plugin = luasnip; }
      { plugin = lspkind-nvim; }
      {
        plugin = nvim-cmp;
        config = "require('cmp').setup(require('cmp_config'))";
        type = "lua";
      }
      {
        plugin = nvim-autopairs;
        config = ''
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          local cmp = require("cmp")
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
          require("nvim-autopairs").setup()
        '';
        type = "lua";
      }
      {
        plugin = lualine-nvim;
        config = ''
          require("lualine").setup({
            options = { theme = "auto" },
          })
        '';
        type = "lua";
      }
      { plugin = vim-commentary; }
    ];

    initLua = ''
      require("options")
      require("keymaps")
    '';
  };

  xdg.configFile."nvim/lua".source = ./lua;
}
