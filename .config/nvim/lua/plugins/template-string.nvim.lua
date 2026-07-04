local filetypes = {

  "html",
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
  "svelte",
  "python",
  "cs",
}

return {
  "axelvc/template-string.nvim",
  ft = filetypes,
  event = "VeryLazy",
  opts = {
    filetypes = filetypes,
    remove_template_string = true,
    restore_quotes = {
      normal = [["]],
      jsx = [["]],
    },
  },
}
