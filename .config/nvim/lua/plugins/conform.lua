return {
  "stevearc/conform.nvim",
  config = function()
    local formatter = require("config.mason.formatter")

    require("conform").setup({
      formatters_by_ft = formatter,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
        })
      end,
    })
  end,
}
