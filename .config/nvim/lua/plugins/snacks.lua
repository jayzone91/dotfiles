return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { enabled = false },
    debug = { enabled = true },
    dim = { enabled = false },
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    image = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    layout = { enabled = false },
    lazygit = { enabled = false },
    notifier = { enabled = true },
    notify = { enabled = true },
    picker = { enabled = true },
    profiler = { enabled = false },
    quickfiel = { enabled = true },
    rename = { enabled = false },
    scope = { enabled = true },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    toggle = { enabled = true },
    util = { enabled = true },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
  },
  init = function()
    --- Advanced LSP Progress
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
  end,
  keys = {
    -- Explorer
    {
      "<leader>e",
      function()
        ---@type fun(opts? : snacks.picker.explorer.Config): snacks.picker
        Snacks.explorer({
          auto_close = true,
          layout = {
            preview = true,
          },
        })
      end,
      desc = "File Explorer",
    },
    -- Terminal
    {
      "<leader>tt",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Toggle Terminal",
    },
    -- Picker & Search
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Search Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep Files",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Search Buffers",
    },
    {
      "<leader>fa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>fd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>fk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
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
  },
}
