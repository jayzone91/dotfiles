-- https://neovim.io/doc/user/options.html#_3.-options-summary

local indent = 2

vim.o.background = "dark"
-- Sync Clipboard between OS and NeoVim.
-- Schedule the settings after "UIEnter" to increase startup time
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.signcolumn = "yes"
vim.o.completeopt = "menu,menuone,noinsert"
vim.o.confirm = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.scrolloff = 8
vim.o.shiftwidth = indent
vim.o.showmode = false
vim.o.sidescrolloff = 8
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.softtabstop = indent
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = indent
vim.o.termguicolors = true
vim.o.timeoutlen = 200
vim.o.title = true
vim.o.updatetime = 250
vim.o.wrap = false
vim.o.cursorline = true
vim.o.inccommand = "split"
