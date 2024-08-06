local parse_hex = function(int_color)
  return string.format("#%x", int_color)
end

local get_buffer_count = function()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.bufname(buf) ~= "" then
      count = count + 1
    end
  end
  return count
end

local get_hlgroup = function(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local group = vim.api.nvim_get_hl(0, { name = name })

    local hl = {
      fg = group.fg == nil and "NONE" or parse_hex(group.fg),
      bg = group.bg == nil and "NONE" or parse_hex(group.bg),
    }
    return hl
  end
  return fallback or {}
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "smiteshp/nvim-navic",
      config = function()
        require("nvim-navic").setup({
          lsp = { auto_attach = true },
          separator = " 󰁔 ",
        })
      end,
    },
  },
  opts = function()
    local filetype_map = {
      lazy = { name = "lazy.nvim", icon = "💤" },
      mason = { name = "mason", icon = "🔨" },
      TelescopePrompt = { name = "telescope", icon = "🔍" },
    }

    return {
      options = {
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
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
              return get_hlgroup("Normal")
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
              local buffer_count = get_buffer_count()

              return "+" .. buffer_count - 1 .. " "
            end,
            cond = function()
              return get_buffer_count() > 1
            end,
            color = get_hlgroup("Operator", nil),
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
            color = get_hlgroup("Special", nil),
          },
          {
            function()
              return require("nvim-navic").get_location()
            end,
            cond = function()
              return package.loaded["nvim-navic"]
                and require("nvim-navic").is_available()
            end,
            color = get_hlgroup("Comment", nil),
          },
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = get_hlgroup("String"),
          },
          { "diff" },
        },
        lualine_y = {
          {
            "progress",
          },
          {
            "location",
            color = get_hlgroup("Boolean"),
          },
        },
        lualine_z = {
          {
            "datetime",
            style = "  %X",
          },
        },
      },
    }
  end,
}
