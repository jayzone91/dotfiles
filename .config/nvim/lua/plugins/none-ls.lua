return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = function()
    return require("plugins.configs.null-ls")
  end,
}
