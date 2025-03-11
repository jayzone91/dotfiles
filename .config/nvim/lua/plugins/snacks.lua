return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>e",
      function()
        Snacks.picker.explorer({
          auto_close = true,
        })
      end,
    },
  },
}
