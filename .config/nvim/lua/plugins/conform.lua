return {
  "stevearc/conform.nvim",
  event = { "BufEnter", "BufNew" },
  config = function()
    local formatter = require("config.formatter")
    require("conform").setup({
      formatters_by_ft = formatter,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
