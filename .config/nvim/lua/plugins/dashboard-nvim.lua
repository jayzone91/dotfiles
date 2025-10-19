return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local logo = require("config.logo").logo

    local dashboard = require("dashboard")

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            action = "Snacks.picker.smart()",
            desc = " Find Files",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          {
            action = "Snacks.picker.recent()",
            desc = " Recent Files",
            icon = " ",
            key = "r",
          },
          {
            action = "Snacks.picker.grep()",
            desc = " Find Text",
            icon = " ",
            key = "g",
          },
          {
            action = "Lazy",
            desc = " Lazy",
            icon = "󰒲 ",
            key = "l",
          },
          {
            action = function()
              vim.api.nvim_input("<cmd>qa<CR>")
            end,
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "⚡ Neovim loaded "
              .. stats.loaded
              .. "/"
              .. stats.count
              .. " plugins in "
              .. ms
              .. "ms",
          }
        end,
      },
    }

    dashboard.setup(opts)

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end
  end,
}
