return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  ---@type cyberdream.Config
  opts = {
    variant = "default",
    transparent = true,
    saturation = 1,
    italic_comments = true,
    hide_fillchars = true,
    borderless_pickers = true,
    terminal_colors = true,
    cache = false,
    ---@type cyberdream.Extensions
    extensions = {
      alpha = false,
      blinkcmp = true,
      cmp = false,
      dapui = false,
      dashboard = false,
      fzflua = false,
      gitpad = false,
      gitsigns = true,
      grapple = false,
      grugfar = true,
      heirline = false,
      helpview = true,
      hop = false,
      indentblankline = false,
      kubectl = false,
      lazy = true,
      leap = false,
      markdown = true,
      markview = true,
      mini = true,
      neogit = false,
      noice = true,
      notify = true,
      rainbow_delimiters = true,
      snacks = true,
      telescope = false,
      treesitter = true,
      treesittercontext = true,
      trouble = true,
      whichkey = true,
    },
  },
  config = function(_, opts)
    require("cyberdream").setup(opts)
    vim.cmd("colorscheme cyberdream")

    vim.api.nvim_create_autocmd("User", {
      pattern = "CyberdreamToggleMode",
      callback = function(event)
        Snacks.notify("Switched to " .. event.data .. " mode!")
      end,
    })

    vim.keymap.set("n", "<leader>tm", ":CyberdreamToggleMode<CR>", { desc = "Toggle cyberdream Mode" })
  end,
}
