return {
  "akinsho/toggleterm.nvim",
  opts = {
    direction = "vertical",
    start_in_insert = true,
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
  },
  keys = {
    {
      "<leader>tt",
      "<cmd>ToggleTerm<CR>",
      mode = { "n" },
      desc = "Toggle Terminal",
    },
  },
}
