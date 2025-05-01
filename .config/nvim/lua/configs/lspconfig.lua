require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "lua_ls",
  "gopls",
  "templ",
  "htmx",
  "tailwindcss",
  "vtsls",
}
vim.lsp.enable(servers)

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
})

vim.lsp.config("gopls", {
  settings = {
    gofumpt = true,
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
})

vim.lsp.config("html", {
  filetypes = { "html", "templ" },
})

vim.lsp.config("htmx", {
  filetypes = { "html", "templ" },
})

vim.lsp.config("tailwindcss", {
  filetypes = { "templ", "astro", "javascript", "typescript", "react" },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        templ = "html",
      },
    },
  },
})

vim.lsp.config("vtsls", {
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
        maxInlayHintLength = 30,
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
})
