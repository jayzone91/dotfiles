-- Plugin: dmmulroy/tsc.nvim
-- Installed via store.nvim

return {
  "dmmulroy/tsc.nvim",
  config = function()
    require("tsc").setup({})
  end,
  keys = {
    { "<leader>to", ":TSCOpen<CR>", desc = "Open TSC" },
    { "<öeader>tc", ":TSCClose<CR>", desc = "Close TSC" },
  },
}

