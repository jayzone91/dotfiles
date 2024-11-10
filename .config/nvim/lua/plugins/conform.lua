return {
  "stevearc/conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer",
  },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua",
        "prettierd",
      },
      auto_update = true,
      run_on_start = true,
    })

    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        ["javascript.jsx"] = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        ["typescript.tsx"] = { "prettierd" },
      },
      format_on_save = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
    })
  end,
}
