-- Bootstrap-like loader: Nix already adds all plugins to the runtimepath,
-- so this simply requires every plugin spec/config in `lua/plugins/*.lua`.
local plug_dir = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.readdir(plug_dir)) do
  if file:match("%.lua$") then
    require("plugins." .. file:gsub("%.lua$", ""))
  end
end