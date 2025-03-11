return {
  "windwp/nvim-ts-autotag",
  opts = {
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
  },
  config = function(_, opts)
    require("nvim-ts-autotag").setup(opts)

    --enable update on insert
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {
          spacing = 5,
          severity_limit = "Warning",
        },
        update_in_insert = true,
      })
  end,
}
