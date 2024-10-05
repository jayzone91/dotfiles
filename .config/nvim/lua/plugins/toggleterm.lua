return {
  "akinsho/toggleterm.nvim",
  keys = {
    {
      "<leader>tt",
      "<cmd>ToggleTerm<CR>",
      desc = "Toggle Terminal",
      mode = "n",
    },
    {
      "<leader>tt",
      "<cmd>ToggleTerm<CR>",
      desc = "Toggle Terminal",
      mode = "t",
    },
  },
  opts = {
    shade_terminals = true,
    direction = "vertical",
    size = vim.o.columns * 0.5,
  },
}
