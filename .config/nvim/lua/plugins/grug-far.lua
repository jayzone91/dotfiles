return {
  "MagicDuck/grug-far.nvim",
  lazy = false,
  opts = {},
  config = function(_, opts)
    require("grug-far").setup(opts)

    vim.keymap.set(
      "n",
      "<leader>fr",
      ":GrugFar<CR>",
      { desc = "Find and Replace (Grug-Far)" }
    )
    vim.keymap.set(
      "v",
      "<leader>fr",
      ":GrugFarWithin<CR>",
      { desc = "Search and Replace Visual (Grug-Far)" }
    )
  end,
}
