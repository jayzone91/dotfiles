-- Check if Neovide extists
if vim.g.neovide then
  require("config/neovide")
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load default options
require("config/options")

local pre = "https://github.com/"

-- Install Plugins
vim.pack.add({
  -- Snacks
  pre .. "folke/snacks.nvim",
  -- LSP Stuff
  pre .. "neovim/nvim-lspconfig",
  pre .. "mason-org/mason.nvim",
  pre .. "mason-org/mason-lspconfig.nvim",
  pre .. "WhoIsSethDaniel/mason-tool-installer.nvim",
  pre .. "j-hui/fidget.nvim",
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  pre .. "folke/lazydev.nvim",

  -- Formatter
  pre .. "stevearc/conform.nvim",

  -- linter
  pre .. "mfussenegger/nvim-lint",

  -- Auto Complete
  { src = pre .. "saghen/blink.cmp", version = "v1" },

  -- Snippets
  pre .. "rafamadriz/friendly-snippets",

  -- Telescope
  pre .. "nvim-telescope/telescope.nvim",

  -- Misc
  pre .. "folke/trouble.nvim",
  pre .. "folke/todo-comments.nvim",
  pre .. "folke/which-key.nvim",
  pre .. "lewis6991/gitsigns.nvim",
  pre .. "nvim-lualine/lualine.nvim",
  { src = pre .. "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  pre .. "windwp/nvim-autopairs",
  pre .. "windwp/nvim-ts-autotag",
  pre .. "MagicDuck/grug-far.nvim",

  -- Colors
  { src = pre .. "catppuccin/nvim", name = "catppuccin" },

  -- Dependencies
  pre .. "nvim-lua/plenary.nvim",
  pre .. "nvim-tree/nvim-web-devicons",
})

-- Configure Plugins
require("plugins/snacks")
require("plugins/lsp")
require("plugins/treesitter")
require("plugins/blink")
require("plugins/misc")
require("plugins/colors")

-- Load Keymaps
require("config/keymaps")

-- Load autocmds
require("config/autocmds")
