local map = function(keys, cmd, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, cmd, { desc = desc, silent = true })
end

map("<leader>w", "<cmd>w<cr>", "Write")
map("<leader>q", "<cmd>q<cr>", "Quit")
map("<leader>h", "<cmd>nohlsearch<cr>", "Clear search highlight")

map("<C-h>", "<C-w>h", "Window left")
map("<C-j>", "<C-w>j", "Window down")
map("<C-k>", "<C-w>k", "Window up")
map("<C-l>", "<C-w>l", "Window right")

map("<leader>ff", "<cmd>Telescope find_files<cr>", "Find files")
map("<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep")
map("<leader>fb", "<cmd>Telescope buffers<cr>", "Buffers")
map("<leader>fh", "<cmd>Telescope help_tags<cr>", "Help")

map("gd", vim.lsp.buf.definition, "Go to definition")
map("gr", vim.lsp.buf.references, "References")
map("K", vim.lsp.buf.hover, "Hover")
map("<leader>ca", vim.lsp.buf.code_action, "Code action")
map("<leader>rn", vim.lsp.buf.rename, "Rename")
map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
map("]d", vim.diagnostic.goto_next, "Next diagnostic")
map("<leader>e", vim.diagnostic.open_float, "Line diagnostic")
