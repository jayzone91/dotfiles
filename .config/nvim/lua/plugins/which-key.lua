return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Split / Search" },
        { "<leader>x", group = "Trouble" },
        { "<leader>q", group = "Quit" },
        { "<leader>t", group = "Toggle" },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
