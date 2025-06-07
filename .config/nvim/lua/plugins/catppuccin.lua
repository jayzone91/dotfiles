return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      transparent_background = true,
      styles = {
        sidebars = "transparent",
        -- floats = "transparent"
      }
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
