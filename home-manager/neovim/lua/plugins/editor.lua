require("which-key").setup()

require("nvim-treesitter").setup({
  highlight = { enable = true },
  indent = { enable = true },
  auto_install = false,
})
-- vim-commentary: no setup needed