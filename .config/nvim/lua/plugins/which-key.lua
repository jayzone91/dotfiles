return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  cmd = "WhichKey",
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>f", group = "Find" },
    })
  end,
}
