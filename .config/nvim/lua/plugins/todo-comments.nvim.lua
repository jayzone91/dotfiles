return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "TodoTrouble" },
  opts = {},
  keys = {
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    {
      "<leader>xT",
      "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
      desc = "Todo/Fix/Fixme (Trouble)",
    },
  },
}
