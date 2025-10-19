return {
  "mfussenegger/nvim-lint",
  config = function()
    local l = require("config.lsp").linter

    l.javascript = { "biomejs" }
    l.javascriptreact = { "biomejs" }
    l.javascript.jsx = { "biomejs" }
    l.typescript = { "biomejs" }
    l.typescriptreact = { "biomejs" }
    l.typescript.tsx = { "biomejs" }

    require("lint").linters_by_ft = l

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
