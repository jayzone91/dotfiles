return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "Spec" },
  opts = {
    spec = {
      {
        mode = { "n", "v" },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
