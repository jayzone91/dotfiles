return {
  "stevearc/conform.nvim",
  config = function()
    local formatters = require("config.formatter")
    require("conform").setup({
      formatters_by_ft = formatters,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
