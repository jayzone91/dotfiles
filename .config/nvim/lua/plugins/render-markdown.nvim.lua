return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    code = {
      sign = false,
      width = "full",
      border = "thin",
      language_icon = true,
      language_name = true,
      right_pad = 1,
    },
    heading = {
      sign = false,
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      position = "inline",
      width = "block",
    },
    bullet = {
      icons = { "●", "○", "◆", "◇" },
    },
    checkbox = {
      enabled = true,
      unchecked = {
        icon = "󰄱 ",
      },
      checked = {
        icon = "󰱒 ",
      },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
      },
    },
    quote = {
      icon = "▎",
    },
    pipe_table = {
      preset = "round",
      cell = "padded",
    },
  },
  ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    Snacks.toggle({
      name = "Render Markdown",
      get = require("render-markdown").get,
      set = require("render-markdown").set,
    }):map("<leader>tm")
  end,
}
