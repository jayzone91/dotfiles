local M = {}

local lsp_server = {
  biome = {},
  cssls = {},
  eslint = {
    settings = {
      workingDirectories = { mode = "auto" },
    },
  },
  html = {},
  lua_ls = {},
  dockerls = {},
  prismals = {},
  docker_compose_language_service = {},
  tailwindcss = {
    filestypes_exclude = { "markdown" },
  },
  pyright = {},
  ruff = {
    cmd_env = { RUFF_TRACE = "messages" },
    init_options = {
      settings = {
        logLevel = "error",
      },
    },
  },
  marksman = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependencies = true,
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
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = {
          "-.git",
          "-.vscode",
          "-.idea",
          "-.vscode-test",
          "-node_modules",
        },
        semanticTokens = true,
      },
    },
  },
  jsonls = {
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(
        new_config.settings.json.schemas,
        require("schemastore").json.schemas()
      )
    end,
    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
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
      complet_function_call = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFuncionCalls = true,
        },
        inlayHints = {
          enumMemberVales = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },
  yamlls = {
    capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
    on_new_config = function(new_config)
      new_config.settings.yaml.schemas = vim.tbl_deep_extend(
        "force",
        new_config.settings.yaml.schemas or {},
        require("schemastore").yaml.schemas()
      )
    end,
    settings = {
      redhat = { telemetry = { enabled = true } },
      yaml = {
        keyOrdering = false,
        format = {
          enable = true,
        },
        validate = true,
        schemastore = {
          enable = false,
          url = "",
        },
      },
    },
  },
}

M.formatter = {
  lua = { "stylua" },
  go = { "goimports", "gofumpt" },
  javascript = { "biome" },
  javascriptreact = { "biome" },
  ["javascript.jsx"] = { "biome" },
  typescript = { "biome" },
  typescriptreact = { "biome" },
  ["typescript.tsx"] = { "biome" },
  css = { "prettier" },
  scss = { "prettier" },
  html = { "prettier" },
  json = { "prettier" },
  markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
  ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
  yaml = { "prettier" },
  dockerfile = { "hadolint" },
}

M.linter = {
  markdown = { "vale" },
}

M.mason = function()
  local ensure_installed = {}

  for server, _ in pairs(lsp_server) do
    table.insert(ensure_installed, server)
  end

  require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
  })

  ensure_installed = {}

  for _, f in pairs(M.formatter) do
    vim.list_extend(ensure_installed, f)
  end

  for _, l in pairs(M.linter) do
    vim.list_extend(ensure_installed, l)
  end

  require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
    auto_update = true,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  if pcall(require, "cmp_nvim_lsp") then
    vim.tbl_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )
  end

  for server, config in pairs(lsp_server) do
    config = config or {}
    vim.tbl_extend("force", { capabilities = capabilities }, config)
    vim.lsp.config(server, config)
  end
end

return M
