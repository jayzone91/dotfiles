return {
  "mfussenegger/nvim-lint",
  config = function()
    local l = require("config.lsp").linter

    local linters = {}

    table.insert(linters, l)

    linters.javascript = { "biomejs" }
    linters.javascriptreact = { "biomejs" }
    linters.javascript.jsx = { "biomejs" }
    linters.typescript = { "biomejs" }
    linters.typescriptreact = { "biomejs" }
    linters.typescript.tsx = { "biomejs" }

    require("lint").linters_by_ft = linters

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
