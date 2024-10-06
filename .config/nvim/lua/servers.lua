local M = {}
M.formatters = {
  css = { "prettierd" },
  html = { "prettierd" },
  go = { "goimports", "gofumpt" },
  javascript = { "prettierd", "eslint_d" },
  javascriptreact = { "prettierd", "eslint_d" },
  typescript = { "prettierd", "eslint_d" },
  typescriptreact = { "prettierd", "eslint_d" },
  json = { "biome" },
  jsonc = { "biome" },
  json5 = { "biome" },
  python = { "black" },
  lua = { "stylua" },
  markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" },
  scss = { "prettierd" },
  sh = { "shfmt" },
  templ = { "templ" },
  toml = { "taplo" },
  php = { "php-cs-fixer" },
  blade = { "blade-formatter" },
  sql = { "sqlfluff" },
  mysql = { "sqlfluff" },
  xml = { "prettierd" },
  plsql = { "sqlfluff" },
  yaml = { "yamlfmt" },
  gha = { "yamlfmt" },
  dependabot = { "yamlfmt" },
}

M.linter = {
  php = { "phpcs" },
  python = { "black" },
  blade = { "tlint" },
  dockerfile = { "hadolint" },
  markdown = { "markdownlint-cli2" },
  lua = { "luacheck" },
  sh = { "shellcheck" },
  sql = { "sqlfluff" },
  mysql = { "sqlfluff" },
  plsql = { "sqlfluff" },
  gha = { "actionlint" },
}

M.lsp = {
  lemminx = {},
  cssls = {},
  html = {
    filetype = {
      "html",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  eslint = {
    settings = {
      workingDirectories = { mode = "auto" },
    },
  },
  emmet_ls = {
    init_options = {
      html = {
        options = {
          ["bem.enabled"] = true,
        },
      },
    },
  },
  bashls = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        hoverKind = "SynopsisDocumentation",
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
  dockerls = {},
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
  rust_analyzer = {},
  templ = {},
  taplo = {
    keys = {
      {
        "K",
        function()
          if
            vim.fn.expand("%:t") == "Cargo.toml"
            and require("crates").popup_available()
          then
            require("crates").show_popup()
          else
            vim.lsp.buf.hover()
          end
        end,
        desc = "Show Crate Documentation",
      },
    },
  },
  intelephense = {},
  pyright = {},
  jsonls = {},
  yamlls = {
    filetypes = {
      "yaml",
      "gha",
      "dependabot",
    },
  },
  tailwindcss = {
    experimental = {
      classRegex = {
        { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
        { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
      },
    },
    init_options = {
      userLanguages = {
        elixir = "phoenix-heex",
        eruby = "erb",
        heex = "phoenix-heex",
      },
    },
    filetypes_exclude = { "markdown" },
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            [[class: "([^"]*)]],
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
  prismals = {},
  ruff = {
    cmd_env = { RUFF_TRACE = "messages" },
    init_options = {
      settings = {
        logLevel = "error",
      },
    },
  },
  volar = {
    init_options = {
      vue = {
        hybridMode = true,
      },
    },
  },
}
return M
