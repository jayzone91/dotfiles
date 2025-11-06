return {
  "mfussenegger/nvim-lint",
  config = function()
    local l = require("config.lint").linter

    require("lint").linters_by_ft = l

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
