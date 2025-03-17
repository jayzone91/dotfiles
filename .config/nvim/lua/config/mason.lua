-- Mason Utils to install
-- LSP Server Config
-- Formatters
-- Linters

local M = {}

M.LSP = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  },
  gopls = {
    filetypes = { "go", "gomod", "gowork", "gotempl" },
    settings = {
      env = {
        GOEXPERIMENT = "rangefunc",
      },
      formatting = {
        gofumpt = true,
      },
    },
  },
  templ = {},
  html = {
    filetypes = { "html", "templ" },
  },
  htmx = {
    filetypes = { "html", "templ" },
  },
  tailwindcss = {
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    settings = {
      tailwindCSS = {
        includeLanguages = {
          templ = "html",
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
  },
}

M.Formatter = {
  lua = { "stylua" },
  go = { "gofumpt", "goimports-reviser", "golines" },
  markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
  ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
  typescript = { "prettier" },
  javascript = { "prettier" },
  typescriptreact = { "prettier" },
  javascriptreact = { "prettier" },
}

M.Linter = {
  markdown = { "markdownlint-cli2" },
}

return M
