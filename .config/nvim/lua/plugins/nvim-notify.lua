---@param name string
local function get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param plugin string
local function has(plugin)
  return get_plugin(plugin) ~= nil
end

return {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismis all notifications",
    },
  },
  opts = {
    stages = "static",
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
  init = function()
    if not has("noice.nvim") then
      vim.notify = require("notify")
    end
  end,
}
