return {
  {
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
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
