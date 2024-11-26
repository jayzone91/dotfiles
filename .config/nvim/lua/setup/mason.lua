local lsp = {
  "lua_ls",
  "cssls",
  "ts_ls",
  "html",
  "stylelint_lsp",
}

local formatter = {
  "stylua",
  "prettierd",
  "prettier",
}

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = lsp,
  automatic_installation = true,
})

require("mason-tool-installer").setup({
  ensure_installed = formatter,
  auto_update = true,
  run_on_start = true,
  debounce_hours = 0,
  integrations = {
    ["mason-lspconfig"] = true,
  },
})
