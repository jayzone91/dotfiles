return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      variant = "default",
      transparent = false,
      italic_comments = true,
      hide_fillchars = true,
      borderless_pickers = true,
      terminal_colors = false,
      cache = true,
    })

    vim.cmd("colorscheme cyberdream")
  end,
}
