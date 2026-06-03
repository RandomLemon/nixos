-- UI
vim.cmd.colorscheme("adwaita-dark")

require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = false },
})

require("lualine").setup({
  options = { theme = "auto" },
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
