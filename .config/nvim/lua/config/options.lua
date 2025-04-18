-- Neovim Options v0.11
-- Documentation: https://neovim.io/doc/user/options.html#_3.-options-summary

-- Set Leader KEys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Default Indent in Spaces
local indent = 2

vim.o.autoindent = true -- Copy indent from current line when starting a new line (typing <CR> in Insert mode or when using the "o" or "O" command).
vim.o.autoread = true -- When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again.
vim.o.background = "dark" -- When set to "dark" or "light", adjusts the default color groups for that background type.
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menu,menuone,noinsert"
vim.o.confirm = true
vim.o.cursorcolumn = false
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.icon = true
vim.o.ignorecase = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.pumblend = 25
vim.o.pumheight = 8
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.shiftround = true
vim.o.shiftwidth = indent
vim.o.showmode = false
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.softtabstop = indent
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = indent
vim.o.termguicolors = true
vim.o.timeoutlen = 250
vim.o.title = true
vim.o.updatetime = 300
vim.o.wrap = false
