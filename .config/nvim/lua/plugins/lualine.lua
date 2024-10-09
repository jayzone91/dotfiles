local function getColor(name2)
  local hl = vim.api.nvim_get_hl
      and vim.api.nvim_get_hl(0, { name = name2, link = false })
    ---@diagnostic disable-next-line:deprecated
    or vim.api.nvim_get_hl_by_name(name2, true)
  ---@diagnostic disable-next-line:undefined-field
  local color2 = hl.background or hl.foreground
  return color2 and string.format("#%06x", color2) or nil
end

local function fg(name)
  local color = getColor(name)
  return color and { fg = color } or nil
end

local function getRealpath(path)
  if path == "" or path == nil then
    return nil
  end
  ---@diagnostic disable-next-line:undefined-field
  path = vim.uv.fs_realpath(path) or path
  return path
end

local function getCwd()
  ---@diagnostic disable-next-line:undefined-field
  return getRealpath(vim.uv.cwd()) or ""
end

local function root_dir(options)
  options = vim.tbl_extend("force", {
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = "󱉭 ",
    color = fg("Special"),
  }, options or {})

  local function get()
    local cwd = getCwd()
    local root = getCwd()
    local name = vim.fs.basename(root)

    if root == cwd then
      -- root is cwd
      return options.cwd and name
    elseif root:find(cwd, 1, true) == 1 then
      -- root is subdirectory of cwd
      return options.subdirectory and name
    elseif cwd:find(root, 1, true) == 1 then
      -- root is parent directory of cwd
      return options.parent and name
    else
      -- root and cwd are not related
      return options.other and name
    end
  end

  return {
    function()
      return (options.icon and options.icon .. " ") .. get()
    end,
    cond = function()
      return type(get()) == "string"
    end,
    color = options.color,
  }
end

local function format(component, text, hl_group)
  text = text:gsub("%%", "%%%%")
  if not hl_group or hl_group == "" then
    return text
  end
  ---@type table<string, string>
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require("lualine.utils.utils")
    ---@type string[]
    local gui = vim.tbl_filter(function(x)
      return x
    end, {
      utils.extract_highlight_colors(hl_group, "bold") and "bold",
      utils.extract_highlight_colors(hl_group, "italic") and "italic",
    })

    lualine_hl_group = component:create_hl({
      fg = utils.extract_highlight_colors(hl_group, "fg"),
      gui = #gui > 0 and table.concat(gui, ",") or nil,
    }, "LV_" .. hl_group) --[[@as string]]
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group)
    .. text
    .. component:get_default_hl()
end

local function pretty_path(options)
  options = vim.tbl_extend("force", {
    relative = "cwd",
    modified_hl = "MatchParen",
    directory_hl = "",
    filename_hl = "Bold",
    modified_sign = "",
    readonly_icon = " 󰌾 ",
    length = 3,
  }, options or {})

  return function(self)
    local path = vim.fn.expand("%:p")
    if path == "" then
      return ""
    end

    local root = getCwd()
    local cwd = getCwd()

    if options.relative == "cwd" and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    else
      path = path:sub(#root + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")
    if options.length == 0 then
      parts = parts
    elseif #parts > options.length then
      parts = {
        parts[1],
        "…",
        table.concat(
          { unpack(parts, #parts - options.length + 2, #parts) },
          sep
        ),
      }
    end

    if options.modified_hl and vim.bo.modified then
      parts[#parts] = parts[#parts] .. options.modified_sign
      parts[#parts] = format(self, parts[#parts], options.modified_hl)
    else
      parts[#parts] = format(self, parts[#parts], options.filename_hl)
    end

    local dir = ""
    if #parts > 1 then
      dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
      dir = format(self, dir .. sep, options.directory_hl)
    end

    local readonly = ""
    if vim.bo.readonly then
      readonly = format(self, options.readonly_icon, options.modified_hl)
    end
    return dir .. parts[#parts] .. readonly
  end
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "pnx/lualine-lsp-status",
  },
  event = "VeryLazy",
  opts = function()
    local ret = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          "lsp-status",
          root_dir(),
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
          {
            "filetype",
            icon_only = true,
            seperator = "",
            padding = { left = 1, right = 0 },
          },
          { pretty_path() },
        },
        lualine_x = {
          {
            function()
              ---@diagnostic disable-next-line:undefined-field
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"]
                ---@diagnostic disable-next-line:undefined-field
                and require("noice").api.status.command.has()
            end,
            color = function()
              return fg("Statement")
            end,
          },
          {
            function()
              ---@diagnostic disable-next-line:undefined-field
              return require("noice").api.status.mode.get()
            end,
            ---@diagnostic disable-next-line:undefined-field
            cond = function()
              return package.loaded["noice"]
                ---@diagnostic disable-next-line:undefined-field
                and require("noice").api.status.mode.has()
            end,
            color = function()
              return fg("Constant")
            end,
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return fg("Special")
            end,
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "neo-tree", "lazy" },
    }

    local has_trouble, trouble = pcall(require, "trouble")
    if has_trouble then
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      table.insert(ret.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    return ret
  end,
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
