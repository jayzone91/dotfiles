require("kanagawa").setup({
  compile = true,
  dimInactive = true,
  overrides = function(colors)
    local theme = colors.theme
    local palette = colors.palette
    return {
      IndentBlankLineChar = { fg = palette.waveBlue2 },
      MiniIndentScopeSymbol = { fg = palette.waveBlue2 },
      PmenuSel = { blend = 0 },
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },
      CursorLineNr = { bg = theme.ui.bg_p2 },
      Visual = { bg = palette.waveBlue2 },
      NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
      LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
    }
  end,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
})

require("kanagawa").load("wave")
