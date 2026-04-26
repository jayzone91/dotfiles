return {
  "folke/snacks.nvim",
  priority = 1000,
  dependencies = {
    { "nvim-mini/mini.icons", opts = {} },
  },
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dasboard = { enabled = false },
    debug = { enabled = false },
    dim = { enabled = false },
    explorer = { enabled = true },
    gh = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enbaled = false },
    image = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    keymap = { enabled = true },
    layout = { enabled = false },
    lazygit = { enabled = false },
    notifier = { enabled = true, timeout = 3000 },
    notify = { enabled = true },
    picker = { enabled = false },
    profiler = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    terminal = { enabled = false },
    toggle = { enabled = true },
    util = { enabled = true },
    win = { enbaled = false },
    words = { enabled = true },
    zen = { enabled = false },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer({
          auto_close = true,
        })
      end,
      desc = "File Explorer",
    },
    {
      "<leader>tt",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Toggle Themes",
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
      "<leader>ff",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
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
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has("nvim-0.11") == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd
        end

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end,
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "none", nocombine = true })
        vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#316c71", bg = "none", nocombine = true })
      end,
    })
  end,
}
