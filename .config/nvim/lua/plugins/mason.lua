return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = false,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local ensure_installed = {}
      local lsp = require("config.lsp")
      local formatter = require("config.formatter")

      for server, _ in pairs(lsp) do
        table.insert(ensure_installed, server)
      end

      for _filetype, formatters in pairs(formatter) do
        for _idx, software in pairs(formatters) do
          table.insert(ensure_installed, software)
        end
      end

      require("mason-tool-installer").setup({
        auto_update = true,
        ensure_installed = ensure_installed,
      })
    end,
  },
}
