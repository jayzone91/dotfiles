local colors = require("catppuccin.palettes").get_palette("mocha")
local noice = require("noice")

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = true,
      theme = "catppuccin",
    },
    sections = {
      lualine_x = {
        {
          ---@diagnostic disable-next-line: undefined-field
          noice.api.status.message.get_hl,
          ---@diagnostic disable-next-line: undefined-field
          cond = noice.api.status.message.has,
        },
        {
          ---@diagnostic disable-next-line: undefined-field
          noice.api.status.command.get,
          ---@diagnostic disable-next-line: undefined-field
          cond = noice.api.status.command.has,
          color = { fg = colors.peach },
        },
        {
          ---@diagnostic disable-next-line: undefined-field
          noice.api.status.mode.get,
          ---@diagnostic disable-next-line: undefined-field
          cond = noice.api.status.mode.has,
          color = { fg = colors.peach },
        },
        {
          ---@diagnostic disable-next-line: undefined-field
          noice.api.status.search.get,
          ---@diagnostic disable-next-line: undefined-field
          cond = noice.api.status.search.has,
          color = { fg = colors.peach },
        },
      },
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
