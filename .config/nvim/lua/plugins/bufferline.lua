return {
  "akinsho/bufferline.nvim",
  version = "*",
  lazy = false,
  config = function()
    require("bufferline").setup({
      options = {
        themeable = true,
        numbers = "both",
        indicator = {
          style = "icon",
        },
        diagnostics = "nvim_lsp",
        color_icons = true,
        show_buffer_icons = true,
        show_close_icons = true,
        show_tab_indicators = true,
        always_show_bufferline = false,
        auto_toggle_bufferline = true,
      },
    })
  end,
}
