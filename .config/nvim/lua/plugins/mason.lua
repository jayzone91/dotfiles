return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    lazy = false,
    opts = function()
      local server = require("config.lsp")
      local ensure_installed = {}

      for key, _ in pairs(server) do
        table.insert(ensure_installed, key)
      end

      return {
        ensure_installed = ensure_installed,
        automatic_installation = true,
      }
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = "williamboman/mason.nvim",
    opts = function()
      local ensure_installed = {}
      local formatter = require("config.formatter")

      for _, value in pairs(formatter) do
        for i = 1, #value, 1 do
          table.insert(ensure_installed, value[i])
        end
      end

      return {
        ensure_installed = ensure_installed,
        auto_update = true,
        run_on_start = true,
      }
    end,
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
    end,
  },
}
