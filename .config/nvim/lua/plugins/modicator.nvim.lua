return {
  "mawkler/modicator.nvim",
  dependencies = "scottmckendry/cyberdream.nvim",
  lazy = false,
  init = function()
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
  opts = {
    show_warnings = true,
    highlights = {
      defaults = {
        bold = true,
        italic = false,
      },
    },
    integration = {
      lualine = {
        enabled = true,
        mode_section = "c",
        highlight = "fg",
      },
    },
  },
}
