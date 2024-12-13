return {
  "stevearc/conform.nvim",
  lazy = false,
  opts = {
    formatters_by_ft = require("config.server").formatter,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = "fallback",
    },
  },
}
