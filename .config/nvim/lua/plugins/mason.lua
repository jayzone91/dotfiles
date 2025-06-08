return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
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
    "neovim/nvim-lspconfig",
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = function()
        local formatters = require("config.formatter")
        local linters = require("config.linter")
        local possibly_installed = {}
        local ensure_installed = {}

        for _, formatter_table in pairs(formatters) do
          for _, formatter in pairs(formatter_table) do
            table.insert(possibly_installed, formatter)
          end
        end

        for _, linter_table in pairs(linters) do
          for _, linter in pairs(linter_table) do
            if linter == "golangcilint" then
              table.insert(possibly_installed, "golangci-lint")
            else
              table.insert(possibly_installed, linter)
            end
          end
        end

        -- sort out duplicates
        local hash = {}
        for _, v in ipairs(possibly_installed) do
          if not hash[v] then
            table.insert(ensure_installed, v)
            hash[v] = true
          end
        end

        local opts = {
          ensure_installed = ensure_installed,
          auto_update = true,
        }

        return opts
      end,
    },
  },
  opts = function()
    local lsps = require("config.lsp")
    local ensure_installed = {}

    for lsp, _ in pairs(lsps) do
      table.insert(ensure_installed, lsp)
    end

    local opts = {
      automatic_enable = false,
      ensure_installed = ensure_installed,
    }
    return opts
  end,
}
