return {
  "axelvc/template-string.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = {
    "html",
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
  },
  config = function()
    require("template-string").setup({
      filetypes = {
        "html",
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
      },
      jsx_brackets = true,
      remove_template_string = false,
      restore_quotes = {
        normal = [["]],
        jsx = [["]],
      },
    })
  end,
}
