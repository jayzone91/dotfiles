return {
  "stevearc/conform.nvim",
  lazy = false,
  config = function()
    local Server = require("config.mason")

    require("conform").setup({
      formatters_by_ft = Server.Formatter,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
