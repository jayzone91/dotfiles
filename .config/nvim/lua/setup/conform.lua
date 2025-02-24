local formatters = require("setup.server.formatter")

require("conform").setup({
  formatters_by_ft = formatters,
  format_on_save = {
    timeout_ms = 1500,
    lsp_format = "fallback",
  },
})
