-- Colorscheme (adwaita-nvim: colorscheme name is "adwaita", darker via g:adwaita_darker)
vim.g.adwaita_darker = true
vim.cmd.colorscheme("adwaita")

-- Status line
require("lualine").setup({
  options = { theme = "adwaita" },
})

-- Indent guides
require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = false },
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