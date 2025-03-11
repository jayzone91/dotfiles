return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "default",
      italic_comments = true,
      hide_fillchars = true,
      terminal_colors = false,
    },
    config = function(_, opts)
      require("cyberdream").setup(opts)
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
}
