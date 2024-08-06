return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      -- enable transparent background
      transparent = true,
      -- enable italic comments
      italic_comments = true,
      -- Replace all fillchars with ' ' for the ultimate clean look
      hide_fillchars = true,
      -- Modern borderless telescope theme
      borderless_telescope = true,
      -- Set terminal colors used in `:terminal`
      terminal_colors = true,
    })

    vim.cmd("colorscheme cyberdream")
  end,
}
