return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "Spec" },
  opts = {
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>f", group = "Find" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Toggle" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "<leader>q", group = "quit" },
        { "<leader>c", group = "code" },
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
