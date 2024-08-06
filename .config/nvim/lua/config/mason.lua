local formatter = require("config.mason.formatter")
local linter = require("config.mason.linter")
local servers = require("config.mason.lsp-server")

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == table then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

local formatters_to_install = {}
for _, value in pairs(formatter) do
  vim.list_extend(formatters_to_install, value)
end

local linter_to_install = {}
for _, value in pairs(linter) do
  vim.list_extend(linter_to_install, value)
end

require("mason").setup({
  ui = {
    border = "rounded",
    width = 0.8,
    height = 0.8,
  },
})

local ensure_installed = {}

vim.list_extend(ensure_installed, servers_to_install)
vim.list_extend(ensure_installed, formatters_to_install)
vim.list_extend(ensure_installed, linter_to_install)

require("mason-tool-installer").setup({
  ensure_installed = ensure_installed,
  auto_update = true,
  run_on_startup = true,
  start_delay = 3000,
})
