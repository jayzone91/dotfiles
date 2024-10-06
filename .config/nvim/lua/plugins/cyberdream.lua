return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  opts = function(_, opts)
    opts.transparent = true
    opts.italic_comments = true
    opts.hide_fillchars = true
    opts.terminal_colors = false
    opts.cache = true
    opts.borderless_telescope = { border = false, style = "flat" }
    opts.theme = {
      variant = "auto",
    }
    opts.extensions = {
      cmp = true,
      gitsigns = true,
      grugfar = true,
      lazy = true,
      markdown = true,
      mini = true,
      noice = true,
      neogit = true,
    }
    return opts
  end,
  config = function(_, opts)
    require("cyberdream").setup(opts)

    vim.cmd("colorscheme cyberdream")
  end,
}
