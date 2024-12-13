return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      background = {
        dark = "mocha",
        light = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        fzf = true,
        treesitter = true,
        mason = true,
        neotree = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        notify = true,
        snacks = true,
        telescope = { enabled = true },
        lsp_trouble = true,
        which_key = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}