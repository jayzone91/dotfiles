local ft = {
  "html",
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreat",
  "vue",
  "svelte",
  "python",
  "cs",
}

return {
  "axelvc/template-string.nvim",
  ft = ft,
  event = "VeryLazy",
  opts = {
    filetypes = ft,
    jsx_brackets = true,
    remove_template_string = true,
    restore_quotes = {
      normal = [["]],
      jsx = [["]],
    },
  },
}
