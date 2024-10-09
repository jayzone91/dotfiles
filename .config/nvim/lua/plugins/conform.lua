return {
  "stevearc/conform.nvim",
  dependencies = "mason.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
    formatters_by_ft = require("config.plugins.mason").formatter,
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
  end,
}
