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

    require("mason-lspconfig").setup({})

    local ensure_installed = {}

    for server, _ in pairs(Servers.LSP) do
      table.insert(ensure_installed, server)
    end
    for _, formatter in pairs(Servers.Formatter) do
      for i = 1, #formatter, 1 do
        table.insert(ensure_installed, formatter[i])
      end
    end

    for _, linter in pairs(Servers.Linter) do
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
