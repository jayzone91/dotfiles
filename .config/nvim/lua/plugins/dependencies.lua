-- Edgy Recommended Settings
-- views can only be fully collapsed with the global statusline
vim.o.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.o.splitkeep = "screen"

return {
  "echasnovski/mini.icons",
  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  { "stevearc/dressing.nvim", opts = {} },
  {
    "folke/todo-comments.nvim",
    opts = {},
    keys = {
      { "<leader>xt", "<cmd>Trouble todo<CR>", desc = "Todos Trouble" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Todos Telescope" },
    },
  },
  { "folke/edgy.nvim", event = "VeryLazy", opts = {} },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  { "b0o/SchemaStore.nvim", version = false },
}
