return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>bP",
      "<Cmd>BufferLineGroupClose ungrouped<CR>",
      desc = "Delete Non-Pinned Buffers",
    },
    {
      "<leader>bo",
      "<Cmd>BufferLineCloseOthers<CR>",
      desc = "Delete Other Buffers",
    },
    {
      "<leader>br",
      "<Cmd>BufferLineCloseRight<CR>",
      desc = "Delete Buffers to the Right",
    },
    {
      "<leader>bl",
      "<Cmd>BufferLineCloseLeft<CR>",
      desc = "Delete Buffers to the Left",
    },
    {
      "<leader>bp",
      "<cmd>BufferLinePick<CR>",
      desc = "Pick open Buffer",
    },
  },
  config = function()
    require("bufferline").setup({
      highlights = {
        buffer_selected = {
          fg = "#5eff6c",
        },
      },
      options = {
        numbers = function(opts)
          ---@diagnostic disable-next-line
          return string.format("%s", opts.raise(opts.ordinal))
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        color_icons = true,
        show_buffer_close_icons = false,
        show_buffer_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        separator_style = "thin",
        always_show_bufferline = false,
        auto_toggle_bufferline = true,
      },
    })
  end,
}
