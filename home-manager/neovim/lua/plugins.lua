-- UI (adwaita-nvim: colorscheme name is "adwaita", darker via g:adwaita_darker)
vim.g.adwaita_darker = true

require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = false },
})

require("lualine").setup({
  options = { theme = "adwaita" },
})

-- File tree (disable netrw so nvim-tree can take over)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  view = {
    width = 32,
    side = "left",
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        git = true,
        folder = true,
        folder_arrow = true,
        file = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      window_picker = { enable = false },
    },
  },
})

-- Git
require("gitsigns").setup()

-- Editor
require("which-key").setup()

require("nvim-treesitter").setup({
  highlight = { enable = true },
  indent = { enable = true },
  auto_install = false,
})

vim.cmd.colorscheme("adwaita")

-- Telescope
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

-- LSP & completion (lsp.lua registers servers; cmp_config is the cmp table)
require("lsp")

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
require("nvim-autopairs").setup()

cmp.setup(require("cmp_config"))
