return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    code = {
      sign = true,
      width = "block",
      right_pad = 1,
    },
    heading = {
      sign = false,
      icons = {},
    },
    checkbock = {
      enabled = true,
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
