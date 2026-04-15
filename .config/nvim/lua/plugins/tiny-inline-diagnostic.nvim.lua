return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      tansparent_background = false,
      options = {
        add_messages = {
          display_count = true,
        },
        multilines = {
          enabled = true,
          always_show = false,
        },
        virt_texts = {
          priority = 2048,
        },
        show_sources = { enabled = true },
      },
      disabled_ft = {},
    })

    vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
  end,
}
