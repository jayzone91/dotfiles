return {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = require("config.linter")

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
