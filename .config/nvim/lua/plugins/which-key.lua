return {
  "folke/which-key.nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {
    icons = {
      rules = false,
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      {
        mode = { "n", "v" },
        { "<leader>f", group = "Find" },
        { "<leader>q", group = "Danger" },
        { "<leader>s", group = "Splits" },
        { "<leader>t", group = "Terminal" },
        { "<leader>x", group = "Trouble" },
        { "<leader>m", group = "Markdown" },
      },
    })
  end,
}
