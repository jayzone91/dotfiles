local builtin = require("telescope.builtin")

return {
  "nvimdev/dashboard-nvim",
  dependencies = {
    "MaximilianLloyd/ascii.nvim",
  },
  lazy = false,
  opts = function()
    local logo = require("ascii").get_random("text", "neovim")
    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = logo,
        center = {
          {
            action = function()
              require("neo-tree.command").execute({ toggle = true })
            end,
            desc = " Open Explorer",
            icon = " ",
            key = "e",
          },
          {
            action = function()
              builtin.find_files()
            end,
            desc = " Find Files",
            icon = " ",
            key = "f",
          },
          {
            action = function()
              builtin.oldfiles()
            end,
            desc = " Recend Files",
            icon = " ",
            key = "r",
          },
          {
            action = function()
              builtin.live_grep()
            end,
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
              vim.api.nvim_input("<cmd>qa<cr>")
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

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end
    return opts
  end,
}
