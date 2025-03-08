return {
  "akinsho/bufferline.nvim",
  lazy = false,
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      themeable = true,
      numbers = "none",
      diagnostics = "nvim_lsp",
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      always_show_bufferline = false,
      auto_toggle_bufferline = true,
    },
  },
}
