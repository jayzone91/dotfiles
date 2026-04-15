return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    background = {
      dark = "mocha",
      light = "auto",
    },
    transparent_background = true,
    float = {
      transparend = true,
    },
    term_colors = true,
    dim_inactive = {
      enabled = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
