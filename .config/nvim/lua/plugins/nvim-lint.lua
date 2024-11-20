return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer",
  },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "eslint_d",
      },
    })
    require("lint").linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typecriptreact = { "eslint_d" },
      ["javascript.jsx"] = { "eslint_d" },
      ["typescript.tsx"] = { "eslint_d" },
    }

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
