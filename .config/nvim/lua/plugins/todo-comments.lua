return {
  "folke/todo-comments.nvim",
  opts = {},
  keys = {
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "TODO",
    },
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "Todo/Fix/Fixme",
    },
  },
}
