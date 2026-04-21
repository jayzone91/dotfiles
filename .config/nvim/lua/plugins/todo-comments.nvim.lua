return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  cmd = { "TodoTrouble" },
  opts = {},
  keys = {
    { "<leader>xt", ":Trouble todo<CR>", desc = "Show Todos" },
  },
}
