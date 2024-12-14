return {
  "mfussenegger/nvim-lint",
  event = { "BufEnter", "BufNew", "InsertLeave" },
  config = function()
    local linter = require("config.server").linter
    require("lint").linters_by_ft = linter

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
      ---@diagnostic disable-next-line:deprecated
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {
          spacing = 5,
          severity_limit = "Warning",
        },
        update_in_insert = true,
      })

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
