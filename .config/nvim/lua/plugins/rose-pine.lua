return {
  "rose-pine/neovim",
  enabled = false,
  lazy = false,
  priority = 1000,
  name = "rose-pine",
  opts = {
    variant = "moon",
    dark_variant = "moon",
    dim_inactive_windows = true,
    extend_background_behind_borders = true,
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd("colorscheme rose-pine")
  end,
}
