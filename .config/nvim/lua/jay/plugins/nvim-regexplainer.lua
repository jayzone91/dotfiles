return {
  "bennypowers/nvim-regexplainer",
  config = function()
    require("regexplainer").setup({
      auto = true,
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
  },
}
