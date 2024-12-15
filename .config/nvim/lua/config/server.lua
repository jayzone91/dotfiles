local M = {}

M.lsp = {
  bashls = {},
  cssls = {},
  docker_compose_language_service = {},
  dockerls = {},
  emmet_ls = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = false,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoyFilters = {
          "-.git",
          "-.vscode",
          "-idea",
          "-.vscode-test",
          "-node_modules",
        },
        semanticTokens = true,
      },
    },
  },
  html = {},
  jsonls = {
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas
      vim.list_extend(
        new_config.settings.json.schemas,
        require("schemastore").json.schemas()
      )
    end,
    settings = {
      json = {
        format = { enable = true },
        validate = { enable = true },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdPary = false,
        },
      },
    },
  },
  marksman = {},
  -- nginx_language_server = {}, -- Geht aktuell nicht, installierte Python Version ist zu neu?!
  prismals = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        diagnostics = { enable = true },
      },
    },
  },
  sqls = {},
  yamlls = {},
  tailwindcss = {
    filetypes_excluse = { "markdown" },
    filetypes_include = {},
  },
  vtsls = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodEAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLenght = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enaled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },
}

M.formatter = {
  lua = { "stylua" },
  javascript = { "prettierd", "prettier" },
  typescript = { "prettierd", "prettier" },
  javascriptreact = { "prettierd", "prettier" },
  typescriptreact = { "prettierd", "prettier" },
  json = { "prettierd", "prettier" },
  markdown = { "prettierd", "prettier", "markdownlint-cli2", "markdown-toc" },
  ["markdown.mdx"] = {
    "prettierd",
    "prettier",
    "markdownlint-cli2",
    "markdown-toc",
  },
  html = { "prettierd", "prettier" },
  toml = { "taplo" },
  css = { "prettierd", "prettier" },
  scss = { "prettierd", "prettier" },
  go = { "goimports", "gofumpt" },
}

M.linter = {
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  dockerfile = { "hadolint" },
  markdown = { "markdownlint-cli2" },
}

return M
