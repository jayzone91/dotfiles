return {
  "stevearc/conform.nvim",
  lazy = false,
  opts = function()
    local formatters = require("config.mason").formatter
    return {
      formatters_by_ft = formatters,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    }
  end,
}
