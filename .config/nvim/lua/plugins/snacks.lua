return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {
      enabled = true,
      notify = true,
      size = 1.5 * 1024 * 1024, -- 1.5MB
      setup = function(ctx)
        vim.cmd([[NoMatchParen]])
        Snacks.util.wo(
          0,
          { foldmethod = "manual", statuscolumn = "", conceallevel = 0 }
        )
        vim.b.minianimate_disable =
          true, vim.schedule(function()
            vim.bo[ctx.buf].syntax = ctx.ft
          end)
      end,
    },
    scope = {
      enabled = true,
    },
    dashboard = {
      enabled = true,
      width = 60,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports "fzf-lua", "telescope.nvim" and "mini.pick"
        ---@type fun(cmd: string, opts:table)|nil
        pick = nil,
        -- Used by the "keys" section to show keymaps.
        -- Set your Custom keymaps here.
        -- When using a function, the "items" argument are the default keymaps
        ---@type snacks.dashboard.Item[]
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
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = "󰒲 ",
            key = "L",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = "", key = "M", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        {
          icon = " ",
          title = "Keymaps",
          section = "keys",
          indent = 2,
          padding = 1,
        },
        {
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
        },
        {
          icon = " ",
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
        },
        { section = "startup" },
      },
    },
    indent = {
      enabled = true,
      scope = {
        treesitter = {
          enabled = true,
        },
      },
    },
    input = {
      enabled = true,
      backdrop = true,
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = {
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        diagnostics = true,
        inlay_hints = false,
      },
      show = {
        statusline = false,
        tabline = false,
      },
    },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    {
      "<leader>z",
      function()
        Snacks.zen()
        Snacks.dim()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>t",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },
  },
  init = function()
    -- Advanced LSP Progress Notifier
    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
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

        local spinner = {
          "⠋",
          "⠙",
          "⠹",
          "⠸",
          "⠼",
          "⠴",
          "⠦",
          "⠧",
          "⠇",
          "⠏",
        }
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

    -- Toggle Snacks
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd

        -- Create some toggle mappings
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end,
    })
  end,
}
