return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,
  config = function()
    require("mini.ai").setup()
    require("mini.pairs").setup()
    require("mini.cursorword").setup()
    require("mini.icons").setup()
    require("mini.statusline").setup()
  end,
}
