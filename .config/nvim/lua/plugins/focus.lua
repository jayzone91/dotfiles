return {
  {
    "nvim-focus/focus.nvim",
    enabled = false,
    version = false,
    config = function()
      require("focus").setup({
        enable = true,
        commands = true,
        autoresize = {
          enable = true,
        },
        ui = {
          number = true,
          relativenumber = true,
          hybridnumber = true,
          colorcolumn = {
            enable = true,
          },
          winhighlight = true,
        },
      })
    end,
  },
}
