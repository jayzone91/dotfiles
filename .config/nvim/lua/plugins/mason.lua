return {
  {
    "mason-org/mason.nvim",
    lazy = true,
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
    dependencies = {
      "neovim/nvim-lspconfig",
      "dart-lang/dart-vim-plugin",
    },
    opts = {
      automatic_enable = true,
      ensure_installed = {
        "lua_ls",
        "gopls",
        "yamlls",
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      vim.lsp.enable("dartls")
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enabled = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      })
    end,
  },
}
