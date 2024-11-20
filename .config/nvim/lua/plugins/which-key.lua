return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    defaults = {},
    spec = {
      {
        { mode = { "n", "v" } },
        { "<leader>f", group = "file/find" },
        { "<leader>c", group = "code" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        {
          "<leader>x",
          group = "diagnostics/quickfix",
          icon = { icon = "󱖫 ", color = "green" },
        },
        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<leader>w",
          group = "windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
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
