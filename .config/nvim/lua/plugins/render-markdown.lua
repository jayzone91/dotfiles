return {
  "MeanderingProgrammer/render-markdown.nvim",
  ---@module "render-markdown"
  ---@type render.md.UserConfig
  opts = {
    code = {
      signs = false,
      width = "block",
      right_pad = 1,
    },
    heading = {
      sign = false,
      icons = {},
    },
    checkbox = {
      enabled = true,
    },
    completions = {
      lsp = { enabled = true },
    },
  },
  ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
  keys = {
    {
      "<leader>tm",
      ":RenderMarkdown toggle<CR>",
      desc = "Toggle Markdown Render",
    },
  },
}
