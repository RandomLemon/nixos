local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(_, bufnr)
  local map = function(keys, fn, desc)
    vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc, silent = true })
  end
  map("gd", vim.lsp.buf.definition, "Definition")
  map("gr", vim.lsp.buf.references, "References")
  map("K", vim.lsp.buf.hover, "Hover")
  map("<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("<leader>rn", vim.lsp.buf.rename, "Rename")
end

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  nixd = {},
  bashls = {},
  jsonls = {},
  yamlls = {},
  rust_analyzer = {},
}

for name, config in pairs(servers) do
  config.capabilities = capabilities
  config.on_attach = on_attach
  require("lspconfig")[name].setup(config)
end
