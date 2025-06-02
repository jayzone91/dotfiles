return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        term_colors = true,
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "dawn",
      dark_variant = "dawn",
      dim_inactive_windows = true,
    },
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparant = true,
      italic_comments = true,
    },
    config = function(_, opts)
      require("cyberdream").setup(opts)
      vim.cmd([[colorscheme cyberdream]])
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
  },
}
