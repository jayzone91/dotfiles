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
}

M.Formatter = {
  lua = { "stylua" },
  go = { "gofumpt", "goimports-reviser", "golines" },
}

M.Linter = {}

return M
