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
  -- LSP Stuff
  pre .. "neovim/nvim-lspconfig",
  pre .. "mason-org/mason.nvim",
  pre .. "mason-org/mason-lspconfig.nvim",
  pre .. "WhoIsSethDaniel/mason-tool-installer.nvim",
  pre .. "j-hui/fidget.nvim",
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

  -- Formatter
  pre .. "stevearc/conform.nvim",

  -- Auto Complete
  pre .. "hrsh7th/nvim-cmp",
  pre .. "hrsh7th/cmp-buffer",
  pre .. "hrsh7th/cmp-path",
  pre .. "hrsh7th/cmp-cmdline",
  pre .. "hrsh7th/nvim-cmp",

  -- Snippets
  pre .. "hrsh7th/cmp-vsnip",
  pre .. "hrsh7th/vim-vsnip",

  -- Telescope
  pre .. "nvim-telescope/telescope.nvim",

  -- Misc
  pre .. "folke/trouble.nvim",

  -- Dependencies
  pre .. "nvim-lua/plenary.nvim",
})

-- Configure Plugins
require("plugins/lsp")
require("plugins/cmp")

require("plugins/misc")

-- Load Keymaps
require("config/keymaps")

-- Load autocmds
require("config/autocmds")
