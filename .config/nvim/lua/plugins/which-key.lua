return {
  "folke/which-key.nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {
    icons = {
      mappings = true,
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
}
