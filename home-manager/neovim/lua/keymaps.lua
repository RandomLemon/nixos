local map = function(keys, cmd, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, cmd, { desc = desc, silent = true })
end

-- General
map("<leader>w", "<cmd>w<cr>", "Write")
map("<leader>q", "<cmd>q<cr>", "Quit")
map("<leader>h", "<cmd>nohlsearch<cr>", "Clear search highlight")

-- Windows
map("<C-h>", "<C-w>h", "Window left")
map("<C-j>", "<C-w>j", "Window down")
map("<C-k>", "<C-w>k", "Window up")
map("<C-l>", "<C-w>l", "Window right")

-- Telescope
map("<leader>ff", "<cmd>Telescope find_files<cr>", "Find files")
map("<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep")
map("<leader>fb", "<cmd>Telescope buffers<cr>", "Buffers")
map("<leader>fh", "<cmd>Telescope help_tags<cr>", "Help")

-- Diagnostics (LSP buffer maps live in lsp.lua on_attach)
map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
map("]d", vim.diagnostic.goto_next, "Next diagnostic")
map("<leader>e", vim.diagnostic.open_float, "Line diagnostic")
