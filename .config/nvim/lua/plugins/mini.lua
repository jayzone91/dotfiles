return {
  {
    "echasnovski/mini.pairs",
    version = false,
    lazy = false,
    opts = {},
  },
  {
    "echasnovski/mini.icons",
    version = false,
    opts = {},
  },
  {
    "echasnovski/mini.map",
    dependencies = {
      {
        "lewis6991/gitsigns.nvim",
        opts = {},
      },
      {
        "echasnovski/mini.diff",
        version = false,
        config = function()
          require("mini.diff").setup()
        end,
      },
    },
    version = false,
    lazy = false,
    cmd = { "MiniMap" },
    config = function()
      local map = require("mini.map")
      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic(),
          map.gen_integration.diff(),
        },
        symbols = {
          encode = map.gen_encode_symbols.dot("4x2"),
        },
      })

      vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
        pattern = "*",
        callback = function()
          MiniMap.open()
        end,
      })

      vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        callback = function()
          MiniMap.refresh()
        end,
      })
    end,
  },
}
