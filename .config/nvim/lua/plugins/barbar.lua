return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    auto_hide = true,
    preset = "powerline",
    insert_at_end = true,
  },
  lazy = false,
  keys = {
    { "<Tab>", "<CMD>BufferNext<CR>", desc = "Next Buffer" },
    { "<S-Tab>", "<CMD>BufferPrevious<CR>", desc = "Prev Buffer" },
  },
}
