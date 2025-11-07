require("config.snacks").progress()

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enable = false },
    bigfile = { enable = true },
    bufdelete = { enable = true },
    dashboard = { enable = true },
    debug = { enable = false },
    dim = { enable = false },
    explorer = {
      enable = true,
    },
    gh = { enable = false },
    git = { enable = true },
    gitbrowse = { enable = false },
    image = { enable = false },
    indent = { enable = true },
    input = { enable = true },
    keymap = { enable = true },
    layout = { enable = false },
    lazygit = { enable = false },
    notifier = { enable = true },
    notify = { enable = true },
    picker = { enable = true },
    profiler = { enable = false },
    quickfile = { enable = true },
    rename = { enable = false },
    scope = { enable = true },
    scratch = { enable = true },
    scroll = { enable = false },
    statuscolumn = { enable = true },
    terminal = { enable = true },
    toggle = { enable = true },
    util = { enable = true },
    win = { enable = true },
    words = { enable = true },
    zen = { enable = false },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      "<leader>ff",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>e",
      function()
        ---@type fun(opts?: snacks.picker.explorer.Config): snacks.Picker
        Snacks.explorer({
          auto_close = true,
        })
      end,
      desc = "File Explorer",
    },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sk",
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
    {
      "gai",
      function()
        Snacks.picker.lsp_incoming_calls()
      end,
      desc = "C[a]lls Incoming",
    },
    {
      "gao",
      function()
        Snacks.picker.lsp_outgoing_calls()
      end,
      desc = "C[a]lls Outgoing",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },
  },
}
