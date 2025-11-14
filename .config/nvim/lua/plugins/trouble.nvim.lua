return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<CR>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble qflist toggle<CR>",
      desc = "Quickfix List (Trouble)",
    },
  },
  opts = {},
}
