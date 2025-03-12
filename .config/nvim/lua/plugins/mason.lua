return {
  "williamboman/mason.nvim",
  lazy = false,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local Servers = require("config.mason")

    local lsp_server = {}

    for server, _ in pairs(Servers.LSP) do
      table.insert(lsp_server, server)
    end

    require("mason-lspconfig").setup({
      ensure_installed = lsp_server,
      automatic_installation = true,
    })

    local ensure_installed = {}

    for _, formatter in ipairs(Servers.Formatter) do
      for i = 1, #formatter, 1 do
        table.insert(ensure_installed, formatter[i])
      end
    end

    for _, linter in ipairs(Servers.Linter) do
      for i = 1, #linter, 1 do
        table.insert(ensure_installed, linter[i])
      end
    end

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
    })
  end,
}
