return {
  "stevearc/conform.nvim",
  opts = function()
    local opts = {}
    local formatter = require("config.formatter")
    opts.formatters_by_ft = formatter
    opts.format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    }
    return opts
  end,
}
