local lsp_server = {
  "cssls", -- CSS
  "tailwindcss", -- TailwindCSS
  "dockerls", -- Docker
  "gopls", -- Go
  "html", -- HTML
  "htmx", -- HTMX
  "vtsls", -- Javascript / Typescript
  "jsonls", -- JSON
  "lua_ls", -- Lua
  "marksman", -- Markdown
  "intelephense", -- PHP
  "powershell_es", -- Powershell
  "prismals", -- Prisma
  "pyright", -- Python
  "rust_analyzer", -- Rust
  "taplo", -- TOML
  "templ", -- Go Templ
  "yamlls", -- YAML
}

local formatter = {
  "stylua", -- Lua
  "prettier", -- Javascript / Typescript / json / html / css / markdown
  "prettierd",
  "goimports", -- Go
  "gofumpt", -- Go
  "markdownlint-cli2", -- Markdown
  "markdown-toc", -- Markdown
  "templ", -- Go Templ
}

local linter = {
  "phpcs", -- PHP
  "hadolint", -- Docker
}

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          border = "rounded",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = "williamboman/mason.nvim",
    opts = function()
      return {
        automatic_installation = true,
        ensure_installed = lsp_server,
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

      for _, f in pairs(formatter) do
        table.insert(ensure_installed, f)
      end

      for _, l in pairs(linter) do
        table.insert(ensure_installed, l)
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
