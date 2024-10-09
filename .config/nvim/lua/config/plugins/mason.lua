local M = {}

M.lsp_server = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        codeLens = {
          true,
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
  bashls = {},
  -- Blade
  stimulus_ls = {},
  cssls = {},
  tailwindcss = {
    filetypes_exclude = { "markdown" },
  },
  docker_compose_language_service = {},
  dockerls = {},
  dotls = {},
  -- html
  emmet_ls = {},
  nil_ls = {},
  gopls = {
    settings = {
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
    },
  },
  html = {},
  eslint = {
    settings = {
      workingDirectories = { mode = "auto" },
    },
  },
  -- js / ts
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
        updateImportOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enaled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literas" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = true },
        },
      },
    },
  },
  -- json
  jsonls = {
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.lsp_extend(
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
  -- markdown
  marksman = {},
  -- php
  intelephense = {},
  powershell_es = {},
  ruff = {
    cmd_env = { RUFF_TRACE = "messages" },
    init_options = {
      settings = {
        logLevel = "error",
      },
    },
  },
  rust_analyzer = {},
  -- toml
  taplo = {},
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
      redhat = { telemetry = { enabled = false } },
      yaml = {
        keyOrdering = false,
        format = { enable = true },
        validate = true,
        schemaStore = {
          enable = false,
          url = "",
        },
      },
    },
  },
  prismals = {},
  omnisharp = {
    handlers = {
      ["textDocument/definition"] = function(...)
        return require("omnisharp_extended").handler(...)
      end,
    },
    keys = {
      {
        "gd",
        function()
          require("omnisharp_extended").telescope_lsp_definitions()
        end,
        desc = "Goto Definition",
      },
    },
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
  },
  volar = {
    init_options = {
      vue = {
        hybridMode = true,
      },
    },
  },
}

M.linter = {
  markdown = { "markdownlint-cli2" },
  php = { "phpcs" },
  dockerfile = { "hadolint" },
}

M.formatter = {
  go = { "goimports", "gofumpt" },
  markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
  php = { "intelephense" },
  lua = { "stylua" },
  nix = { "nixfmt" },
  cs = { "csharpier" },
}

function M.setup()
  local lsp_to_install = vim.tbl_filter(function(key)
    local t = M.lsp_server[key]
    if type(t) == "table" then
      return not t.manual_install
    else
      return t
    end
  end, vim.tbl_keys(M.lsp_server))

  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = lsp_to_install,
    automatic_installation = true,
  })

  local tool_installer_ensure_installed = {}
  for _, key in pairs(M.formatter) do
    vim.list_extend(tool_installer_ensure_installed, key)
  end

  for _, key in pairs(M.linter) do
    vim.list_extend(tool_installer_ensure_installed, key)
  end

  require("mason-tool-installer").setup({
    ensure_installed = tool_installer_ensure_installed,
    auto_update = true,
  })
end

return M
