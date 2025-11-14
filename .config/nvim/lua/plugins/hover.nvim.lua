return {
  "lewis6991/hover.nvim",
  init = function()
    vim.o.mousemoveevent = true
  end,
  ---@module "hover"
  ---@type Hover.UserConfig
  opts = {
    ---@type (string|Hover.Config.Provider)[]
    providers = {
      "hover.providers.diagnostic",
      "hover.providers.lsp",
      "hover.providers.dap",
      "hover.providers.man",
      "hover.providers.dictionary",
      "hover.providers.gh",
    },
    preview_opts = {
      border = "double",
    },
    preview_window = false,
    title = true,
    mouse_providers = {
      "hover.providers.lsp",
    },
    mouse_delay = 1000,
  },
  keys = {
    {
      "H",
      function()
        require("hover").open()
      end,
      desc = "hover.nvim (open)",
    },
    {
      "gK",
      function()
        require("hover").enter()
      end,
      desc = "hover.nvim (enter)",
    },
    {
      "<MouseMove>",
      function()
        require("hover").mouse()
      end,
      desc = "hover.nvim (mouse)",
    },
  },
}
