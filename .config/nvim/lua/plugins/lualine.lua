return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.icons" },
  opts = function()
    local utils = require("utils")
    local filetype_map = {
      lazy = { name = "lazy.nvim", icon = "💤" },
      minifiles = { name = "minifiles", icon = "🗂️ " },
      toggleterm = { name = "terminal", icon = "🐚" },
      mason = { name = "mason", icon = "🔨" },
      TelescopePrompt = { name = "telescope", icon = "🔍" },
    }

    return {
      options = {
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = {
          statusline = {
            "dashboard",
            "alpha",
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              icon = "",
              fmt = function(mode)
                return mode:lower()
              end,
            },
          },
          lualine_b = { { "branch", icon = "" } },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = "󰝶 ",
              },
            },
            {
              function()
                local devicons = require("nvim-web-devicons")
                local ft = vim.bo.filetype
                local icon
                if filetype_map[ft] then
                  return " " .. filetype_map[ft].icon
                end
                if icon == nil then
                  icon = devicons.get_icon(vim.fn.expand("%:t"))
                end
                if icon == nil then
                  icon = devicons.get_icon_by_filetype(ft)
                end
                if icon == nil then
                  icon = " 󰈤"
                end

                return icon .. " "
              end,
              color = function()
                local _, hl =
                  require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"))
                if hl then
                  return hl
                end
                return utils.get_hlgroup("Normal")
              end,
              separator = "",
              padding = { left = 0, right = 0 },
            },
            {
              "filename",
              padding = { left = 0, right = 0 },
              fmt = function(name)
                if filetype_map[vim.bo.filetype] then
                  return filetype_map[vim.bo.filetype].name
                else
                  return name
                end
              end,
            },
            {
              function()
                local buffer_count = utils.get_buffer_count()
                return "+" .. buffer_count - 1 .. " "
              end,
              cond = function()
                return utils.get_buffer_count() > 1
              end,
              color = utils.get_hlgroup("Operator", nil),
              padding = { left = 0, right = 1 },
            },
            {
              function()
                local tab_count = vim.fn.tabpagenr("$")
                if tab_count > 1 then
                  return vim.fn.tabpagenr() .. " of " .. tab_count
                end
              end,
              cond = function()
                return vim.fn.tabpagenr("$") > 1
              end,
              icon = "󰓩",
              color = utils.get_hlgroup("Special", nil),
            },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"]
                  and require("nvim-navic").is_available()
              end,
              color = utils.get_hlgroup("Comment", nil),
            },
          },
          lualine_x = {
            {
              require("lazy.status").upates,
              cond = require("lazy.status").has_update,
              color = utils.get_hlgroup("String"),
            },
            {
              "diff",
            },
          },
          lualine_y = {
            {
              "progress",
            },
            {
              "location",
              color = utils.get_hlgroup("Boolean"),
            },
          },
          lualine_z = {
            {
              "datetime",
              style = "  %X",
            },
          },
        },
      },
    }
  end,
}
