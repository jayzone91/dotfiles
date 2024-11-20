local custom_catppuccin = require("lualine.themes.catppuccin-mocha")

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = custom_catppuccin,
      },
    })
  end,
}
