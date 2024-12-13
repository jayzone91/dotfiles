local M = {}

M.lsp = {
  bashls = {},
  cssls = {},
  docker_compose_language_service = {},
  dockerls = {},
  emmet_ls = {},
  gopls = {},
  html = {},
  vtsls = {},
  jsonls = {},
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
}

M.formatter = {
  lua = { "stylua" },
  javascript = { "prettierd", "prettier" },
  typescript = { "prettierd", "prettier" },
  javascriptreact = { "prettierd", "prettier" },
  typescriptreact = { "prettierd", "prettier" },
  json = { "prettierd", "prettier" },
  markdown = { "prettierd", "prettier" },
  html = { "prettierd", "prettier" },
  toml = { "taplo" },
  css = { "prettierd", "prettier" },
  scss = { "prettierd", "prettier" },
}

return M
