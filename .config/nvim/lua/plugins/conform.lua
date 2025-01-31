return {
  "stevearc/conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  event = "BufEnter",
  config = function()
    require("conform").setup({
      formatters_by_ft = require("config.formatter"),
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
