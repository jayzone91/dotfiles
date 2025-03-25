-- Advanced LSP Progress
---@type table<number, {token:lsp.ProgressToken, msg: string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin"|"report"|"end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner =
      { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

return {
  "folke/snacks.nvim",
  dependencies = {
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts = {},
    },
    {
      "s1n7ax/nvim-window-picker",
      name = "window-picker",
      opts = {
        hint = "floating-big-letter",
        show_prompt = false,
        filter_rules = {
          autoselect_one = true,
          include_current_win = false,
          include_unfocusable_windows = false,
            -- stylua: ignore
            bo = {
              filetype = { "snacks_picker_input", "snacks_picker_list", "NvimTree", "neo-tree", "notify", "snacks_notif", },
              buftype = { "terminal", "nofile", "quickfix", "help", "prompt", "notify", "float" },
            },
        },
      },
    },
  },
  lazy = false,
  priority = 1000,
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = " ",
            key = "n",
            desc = "New File",
            action = ":ene | startinsert",
          },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = "󰒲 ",
            key = "l",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          {
            icon = "",
            key = "m",
            desc = "Mason",
            action = ":Mason",
          },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        {
          icon = " ",
          title = "Keymaps",
          section = "keys",
          gap = 1,
          padding = 1,
          indent = 2,
        },
        {
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          indent = 2,
          ttl = 5 * 60,
          gap = 1,
        },
        { section = "startup" },
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    image = {
      formats = {
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
        "pdf",
      },
      force = false,
    },
    notifier = { enabled = true },
    notify = { enabled = true },
    picker = {
      enabled = true,
      ui_select = true,
      sources = {
        explorer = {
          actions = {
            flash = function(picker)
              require("flash").jump({
                pattern = "^",
                label = { after = { 0, 0 } },
                search = {
                  mode = "search",
                  exclude = {
                    function(win)
                      return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
                        ~= "snacks_picker_list"
                    end,
                  },
                },
                action = function(match)
                  local idx = picker.list:row2idx(match.pos[1])
                  picker.list:_move(idx, true, true)
                end,
              })
            end,
            window_picker = function(_, item)
              if item.dir then
                return
              end

              local window_id = require("window-picker").pick_window()

              if not window_id then
                return
              end

              vim.api.nvim_set_current_win(window_id)
              vim.cmd("edit " .. item._path)
              Snacks.explorer()
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-s>"] = { "flash", mode = { "n", "i" } },
                ["s"] = { "flash" },
              },
            },
            list = {
              keys = {
                ["w"] = "window_picker",
              },
            },
          },
        },
      },
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    zen = {
      enabled = true,
      toggles = {
        dim = true,
        git_signs = false,
      },
      show = {
        statusline = false,
        tabline = false,
      },
      win = {
        style = "zen",
      },
      zoom = {
        toggles = {},
        show = {
          statusline = false,
          tabline = false,
        },
        win = {
          backdrop = true,
          width = 0,
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer.open({
          hidden = true,
          ignored = true,
          auto_close = true,
        })
      end,
      desc = "Open Explorer",
    },
    {
      "<leader>zz",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Zen Mode",
    },
    {
      "<leader>zm",
      function()
        Snacks.zen()
      end,
      desc = "Zen Mode",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Search Buffers",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Find Keymaps",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Live Grep",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Find Help",
    },
    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    -- image
    {
      "<leader>si",
      function()
        Snacks.image.hover()
      end,
      desc = "Show the image at the cursor in a floating window",
    },
  },
}
