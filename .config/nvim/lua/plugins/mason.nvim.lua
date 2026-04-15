local lsp_server = require("installs.lsp")

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
  { "mason-org/mason-lspconfig.nvim", opts = {} },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function()
      -- install tools
      local ensure_installed = {}

      local linter = require("installs.linter")
      local formatter = require("installs.formatter")

      for x, _ in pairs(lsp_server) do
        table.insert(ensure_installed, x)
      end

      for _, x in pairs(linter) do
        vim.list_extend(ensure_installed, x)
      end

      for _, x in pairs(formatter) do
        vim.list_extend(ensure_installed, x)
      end

      return {
        ensure_installed = ensure_installed,
        auto_update = true,
      }
    end,
  },
}
