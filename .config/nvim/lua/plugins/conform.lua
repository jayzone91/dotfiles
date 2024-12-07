local Server = require("server")

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = Server.formatter,
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
