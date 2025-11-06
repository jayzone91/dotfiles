local M = {}

M.formatter = {
  lua = { "stylua" },
  javascript = { "prettier" },
  javascriptreact = { "prettier" },
  ["javascript.jsx"] = { "prettier" },
  typescript = { "prettier" },
  typescriptreact = { "prettier" },
  ["typescript.tsx"] = { "prettier" },
  css = { "prettier" },
  html = { "prettier" },
  scss = { "prettier" },
  json = { "prettier" },
  markdown = { "prettier" },
  yaml = { "prettier" },
}

M.conform = function()
  return {
    formatters_by_ft = M.formatter,
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  }
end

return M
