local M = {}

M.lsp = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        codeLens = {
          enable = true,
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
  },
  gopls = {
    gofump = true,
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
    directoryFilters = {
      "-.git",
      "-.vscode",
      "-.idea",
      "-.vscode-test",
      "-node_modules",
    },
    semanticTokens = true,
  },
  jsonls = {
    on_new_config = function(new_config)
      local ok, store = pcall(require, "schemastore")
      if ok then
        new_config.settings.json.schemas = new_config.settings.json.schemas
          or {}
        vim.list_extend(new_config.settings.json.schemas, store.json.schemas())
      end
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
  marksman = {},
  intelephense = {
    filetypes = { "php", "blade", "php_only" },
    settings = {
      intelephense = {
        filetypes = { "php", "blade", "php_only" },
        files = {
          associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
          maxSize = 5000000,
        },
      },
    },
  },
  prismals = {},
  ruff = {
    cmd_env = { RUFF_TRACE = "messages" },
    init_options = {
      settings = {
        logLevel = "error",
      },
    },
  },
  tailwindcss = {
    filetypes_exclude = { "markdown" },
    filetypes_include = {},
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            "@?class\\(([^]*)\\)",
            "'([^']*)'",
          },
        },
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
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
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
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },
  eslint = {
    settings = {
      -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
      workingDirectories = { mode = "auto" },
    },
  },
  emmet_ls = {
    filetypes = {
      "astro",
      "blade",
      "css",
      "eruby",
      "html",
      "htmldjango",
      "javascriptreact",
      "less",
      "pug",
      "sass",
      "scss",
      "svelte",
      "typescriptreact",
      "vue",
    },
  },
}

M.formatter = {
  lua = { "stylua" },
  sh = { "shfmt" },
  python = { "black" },
  javascript = { "prettierd" },
  typescript = { "prettierd" },
  javascriptreact = { "prettierd" },
  typescriptreact = { "prettierd" },
  css = { "prettierd" },
  html = { "prettierd" },
  json = { "prettierd" },
  markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" },
  scss = { "prettierd" },
  go = { "goimports", "gofumpt" },
  php = { "php-cs-fixer", "pint" },
  blade = { "blade-formatter", "rustywind" },
}

M.linter = {
  fish = { "fish" },
  markdown = { "markdownlint-cli2" },
  php = { "phpcs" },
}

return M
