return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "InsertLeave" },
  config = function()
    require("lint").linters_by_ft = require("config.mason").linter

    vim.api.nvim_create_autocmd(
      { "BufWritePost", "BufReadPost", "InsertLeave" },
      {
        callback = function()
          require("lint").try_lint()
        end,
      }
    )
  end,
}
