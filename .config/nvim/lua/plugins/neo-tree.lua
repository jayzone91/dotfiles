return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "float",
      },
    })

    vim.keymap.set(
      "n",
      "<leader>e",
      "<cmd>Neotree toggle<CR>",
      { desc = "Toggle Explorer" }
    )
  end,
}
