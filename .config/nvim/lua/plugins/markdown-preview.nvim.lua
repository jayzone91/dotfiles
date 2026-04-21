return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = "cd app && npx --yes yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  keys = {
    {
      "<leader>tp",
      ft = "markdown",
      "<cmd>MarkdownPreviewToggle<CR>",
      desc = "Markdown Preview",
    },
  },
  config = function()
    vim.cmd([[do FileType]])
  end,
}
