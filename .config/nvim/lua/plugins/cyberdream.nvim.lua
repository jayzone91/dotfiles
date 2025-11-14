return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = false,
      italic_comments = true,
      hide_fillchars = false,
      terminal_colors = true,
      borderless_pickers = false,
      theme = {
        highlights = {
          RainbowDelimiterRed = { fg = "#ff5ef1" },
          RainbowDelimiterYellow = { fg = "#ffbd5e" },
          RainbowDelimiterBlue = { fg = "#5ef1ff" },
          RainbowDelimiterOrange = { fg = "#ff6e5e" },
          RainbowDelimiterGreen = { fg = "#5eff6c" },
          RainbowDelimiterViolet = { fg = "#bd5eff" },
          RainbowDelimiterCyan = { fg = "#5ea1ff" },
          PackageInfoOutdatedVersion = { fg = "#ff6e5e" },
          PackageInfoUpToDateVersion = { fg = "#5ea1ff" },
          Hlargs = { fg = "#ff5ef1" },
          NormalMode = { fg = "#5ea1ff" },
          InsertMode = { fg = "#5eff6c" },
          VisualMode = { fg = "#ff5ef1" },
          CommandMode = { fg = "#5ef1ff" },
          ReplaceMode = { fg = "#ff6e5e" },
          SelectMode = { fg = "#5ea1ff" },
          TerminalMode = { fg = "#ffbd5e" },
          TerminalNormalMode = { fg = "#ffbd5e" },
          LspInfoBorder = { fg = "#7b8496" },
          GitSignsCurrentLineBlame = { fg = "#adb1ba" },
        },
      },
    })
    vim.cmd("colorscheme cyberdream")
  end,
}
