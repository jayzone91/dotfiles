return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    preset = {
      pick = "telescope.nvim",
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
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
    words = {
      enabled = true, -- enable/disable the plugin
      debounce = 200, -- time in ms to wait before updating
      notify_jump = false, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { "n", "i", "c" }, -- modes to show references
    },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          section = "terminal",
          cmd = "pokemon-colorscripts -r --no-title; sleep .1",
          random = 10,
          pane = 2,
          indent = 4,
          height = 30,
        },
      },
    },
    notifier = {
      enabled = true,
    },
    quickfile = {
      enabled = true,
      exclude = { "latex" },
    },
    statuscolumn = {
      enabled = true,
    },
    terminal = {
      enabled = true,
    },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
  },
  keys = {
    {
      "<leader>tt",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },
  },
}
