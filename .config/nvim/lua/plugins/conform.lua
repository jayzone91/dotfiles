return {
  "stevearc/conform.nvim",
  config = function()
    local mason_config = require("config.mason-config")

    require("conform").setup({
      formatters_by_ft = mason_config.formatter,
      format_on_save = {
        timeout_ms = 2500,
        lsp_format = "fallback",
      },
    })
  end,
}
