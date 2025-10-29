-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "pastelDark",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.nvdash = {
  load_on_startup = true,
  buttons = {
    { txt = "  Find File", keys = "f", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "o", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "g", cmd = "Telescope live_grep" },
    {
      txt = "󰚰  Install Mason Packages",
      keys = "m",
      cmd = "MasonInstallAll",
    },
    { txt = "󰉁  Lazy", keys = "l", cmd = "Lazy" },
    { txt = "  Quit NeoVim", keys = "q", cmd = "qa" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

return M
