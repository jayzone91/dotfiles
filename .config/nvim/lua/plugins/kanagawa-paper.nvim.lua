return {
  "thesimonho/kanagawa-paper.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    dim_inactive = true,
  },
  init = function()
    vim.cmd.colorscheme("kanagawa-paper-ink")
  end,
}
