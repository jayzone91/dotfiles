return {
  "axelvc/template-string.nvim",
  ft = {
    "html",
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "vue",
    "svelte",
    "python",
    "cs",
  },
  event = "VeryLazy",
  opts = {
    filetypes = {
      "html",
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "vue",
      "svelte",
      "python",
      "cs",
    },
    remove_template_string = true,
    restore_quotes = {
      normal = [["]],
      jsx = [["]],
    },
  },
}
