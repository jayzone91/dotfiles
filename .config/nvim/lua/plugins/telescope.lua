return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fg",
      LazyVim.pick("live_grep"),
      desc = "Live Grep",
    },
    {
      "<leader><space>",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>",
      desc = "Search current Buffers",
    },
  },
}
