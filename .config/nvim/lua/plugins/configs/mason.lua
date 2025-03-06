local tools = {
  "gofumpt",
  "goimports",
  "golines",
  "rustfmt",
  "stylua",
}

local ensure_installed = {}

for key, _ in pairs(require("plugins.configs.lsp")) do
  table.insert(ensure_installed, key)
end

require("mason-lspconfig").setup({
  ensure_installed = ensure_installed,
  automatic_installation = true,
})

require("mason-tool-installer").setup({
  ensure_installed = tools,
  auto_update = true,
})
