return {
  "folke/todo-comments.nvim",
  cmd = "TodoTelescope",
  event = "BufRead",
  keys = {
    { "<leader>fd", "<cmd>TodoTelescope<CR>", desc = "Todo" },
  },
  config = function()
    require("todo-comments").setup()
  end,
}
