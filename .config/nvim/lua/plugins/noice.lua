return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "rcarriga/nvim-notify",
  },
  config = function()
    require("config.plugins.noice")
  end,
}
