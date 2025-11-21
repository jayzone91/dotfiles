-- Plugin: Bekaboo/deadcolumn.nvim
-- Installed via store.nvim

return {
  "Bekaboo/deadcolumn.nvim",
  event = "VeryLazy",
  opts = {},
  init = function()
    vim.o.colorcolumn = "80"
  end,
}
