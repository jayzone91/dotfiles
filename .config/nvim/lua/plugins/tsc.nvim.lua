return {
  "dmmulroy/tsc.nvim",
  config = function()
    require("tsc").setup({})
  end,
  keys = {
    { "<leader>to", ":TSCOpen<CR>", desc = "Open TSC" },
    { "<leader>tc", ":TSCClose<CR>", desc = "Close TSC" },
  },
}
