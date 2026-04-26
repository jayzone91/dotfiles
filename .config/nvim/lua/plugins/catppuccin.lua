return {
  "catppuccin/nvim",
  enabled = false,
  name = "catppuccin",
  priority = 1000,
  ---@type CatppuccinOptions
  opts = {
    flavour = "mocha",
    background = {
      dark = "mocha",
      light = "auto",
    },
    transparent_background = true,
    float = {
      transparent = true,
      solid = false,
    },
    term_colors = true,
    dim_inactive = {
      enabled = true,
    },
    lsp_styles = {
      underlines = {
        error = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    integrations = {
      gitsigns = true,
      lsp_trouble = true,
      mason = true,
      mini = true,
      notify = true,
      snacks = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
