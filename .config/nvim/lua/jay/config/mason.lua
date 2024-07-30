local M = {}

M.lspserver = {
  lua_ls = {
    server_capabilities = {
      semanticTokensProvider = vim.NIL,
    },
  },
  gopls = {},
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { "W391" },
            maxLineLength = 100,
          },
        },
      },
    },
  },
  cssls = {},
  html = {
    filetypes = {
      "html",
      "templ",
    },
  },
  intelephense = {},
  jsonls = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        diagnostics = {
          enable = true,
        },
      },
    },
  },
  templ = {},
  tsserver = {},
  tailwindcss = {
    filetypes = {
      "aspnetcorerazor",
      "astro",
      "astro-markdown",
      "blade",
      "clojure",
      "django-html",
      "htmldjango",
      "edge",
      "eelixir",
      "elixir",
      "ejs",
      "erb",
      "eruby",
      "gohtml",
      "gohtmltmpl",
      "haml",
      "handlebars",
      "hbs",
      "html",
      "htmlangular",
      "html-eex",
      "heex",
      "jade",
      "leaf",
      "liquid",
      "markdown",
      "mdx",
      "mustache",
      "njk",
      "nunjucks",
      "php",
      "razor",
      "slim",
      "twig",
      "css",
      "less",
      "postcss",
      "sass",
      "scss",
      "stylus",
      "sugarss",
      "javascript",
      "javascriptreact",
      "reason",
      "rescript",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "templ",
    },
  },
}

M.linter = {
  python = { "flake8" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

M.formatter = {
  lua = { "stylua" },
  python = { "isort", "black" },
  go = { "goimports", "golines" },
  javascript = { "prettierd" },
  typescript = { "prettierd" },
  javascriptreact = { "prettierd" },
  typescriptreact = { "prettierd" },
  html = { "prettierd" },
  yaml = { "prettierd" },
  css = { "prettierd" },
  markdown = { "prettierd" },
  tailwindcss = { "rustywind" },
}

return M
