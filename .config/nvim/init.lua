require("config.options")
require("config.keymaps")
require("config.autocommands")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">"
      or vim.schedule(function()
        vim.cmd.wincmd(dir)
      end)
  end
end

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { "folke/todo-comments.nvim", opts = {} },
    {
      "folke/ts-comments.nvim",
      event = "VeryLazy",
      opts = {},
    },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = function()
        ---@type snacks.Config
        return {
          terminal = {
            win = {
              keys = {
                nav_h = {
                  "<C-h>",
                  term_nav("h"),
                  desc = "Go to Left Window",
                  expr = true,
                  mode = "t",
                },
                nav_j = {
                  "<C-j>",
                  term_nav("j"),
                  desc = "Go to Lower Window",
                  expr = true,
                  mode = "t",
                },
                nav_k = {
                  "<C-k>",
                  term_nav("k"),
                  desc = "Go to Upper Window",
                  expr = true,
                  mode = "t",
                },
                nav_l = {
                  "<C-l>",
                  term_nav("l"),
                  desc = "Go to Right Window",
                  expr = true,
                  mode = "t",
                },
              },
            },
          },
        }
      end,
      keys = {
        {
          "<leader>un",
          function()
            Snacks.notifier.hide()
          end,
          desc = "Dismiss All Notifications",
        },
      },
    },
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "catppuccin", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
