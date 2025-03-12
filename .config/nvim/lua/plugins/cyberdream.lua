return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "default",
      transparent = false,
      italic_comments = true,
      hide_fillchars = true,
      borderless_pickers = true,
      terminal_colors = false,
    },
    config = function(_, opts)
      require("cyberdream").setup(opts)
      vim.cmd("colorscheme cyberdream")
    end,
  },
}
