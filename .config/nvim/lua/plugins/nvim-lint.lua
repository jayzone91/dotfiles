return {
  "mfussenegger/nvim-lint",
  config = function()
    local linter = require("config.mason.linter")
    require("lint").linters_by_ft = linter

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
