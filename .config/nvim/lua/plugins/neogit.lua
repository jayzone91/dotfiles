return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
  },
  config = function()
    require("neogit").setup({
      integrations = {
        telescope = true,
        diffview = true,
      },
    })

    vim.keymap.set(
      "n",
      "<leader>gn",
      "<cmd>Neogit<CR>",
      { desc = "Open Neogit" }
    )
    vim.keymap.set(
      "n",
      "<leader>gc",
      "<cmd>Neogit commit<CR>",
      { desc = "Open commit popup" }
    )
  end,
}
