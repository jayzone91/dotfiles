return {
  "stevearc/conform.nvim",
  opts = function()
    local formatter = require("installs.formatter")

    return {
      formatters_by_ft = formatter,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    }
  end,
}
