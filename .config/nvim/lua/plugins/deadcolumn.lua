return {
  "Bekaboo/deadcolumn.nvim",
  lazy = false,
  config = function()
    require("deadcolumn").setup()

    vim.o.termguicolors = true
    vim.o.colorcolumn = "80"
  end,
}
