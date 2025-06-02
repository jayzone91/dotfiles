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
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        handlers = {},
        ensure_installed = {},
      })
      local ensure_installed = {}
      local lsp = require("config.lsp")
      local formatter = require("config.formatter")
      local linter = require("config.linter")
      local debugger = require("config.debugger")

      for server, _ in pairs(lsp) do
        table.insert(ensure_installed, server)
      end

      for _, dap in pairs(debugger) do
        table.insert(ensure_installed, dap)
      end

      for _, formatters in pairs(formatter) do
        for _, software in pairs(formatters) do
          table.insert(ensure_installed, software)
        end
      end

      for _, lint in pairs(linter) do
        for _, software in pairs(lint) do
          if software == "golangcilint" then
            table.insert(ensure_installed, "golangci-lint")
          else
            table.insert(ensure_installed, software)
          end
        end
      end

      require("mason-tool-installer").setup({
        auto_update = true,
        ensure_installed = ensure_installed,
      })
    end,
  },
}
