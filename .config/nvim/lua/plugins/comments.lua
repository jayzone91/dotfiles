return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = {
    {
      "<leader>ft",
      function()
        ---@diagnostic disable-next-line:undefined-field
        Snacks.picker.todo_comments()
      end,
      desc = "Todo",
    },
    {
      "<leader>fT",
      function()
        ---@diagnostic disable-next-line:undefined-field
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "Todo/Fix/Fixme",
    },
  },
}
