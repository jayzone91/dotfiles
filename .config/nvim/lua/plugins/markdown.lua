return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
    end,
    keys = {
      {
        "<leader>mr",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        icon_provider = "internal",
      },
    },
    config = function(_, opts)
      require("markview").setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "MarkviewAttach",
        callback = function(event)
          local data = event.data
          vim.print(data)
        end,
      })
    end,
  },
}
