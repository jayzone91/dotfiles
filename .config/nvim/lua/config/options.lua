-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.confirm = true
vim.o.hlsearch = false
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.backup = false
vim.o.writebackup = false
vim.opt.termguicolors = true
vim.o.whichwrap = "bs<>[]hl"
vim.o.wrap = false
vim.o.linebreak = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.numberwidth = 2
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.smartindent = true
vim.o.showmode = false
vim.o.showtabline = 2
vim.o.backspace = "indent,eol,start"
vim.o.pumheight = 10
vim.o.conceallevel = 0
vim.o.fileencoding = "utf-8"
vim.o.cmdheight = 1
vim.o.autoindent = true
vim.opt.shortmess:append("c")
vim.opt.iskeyword:append("-")
vim.opt.formatoptions:remove({ "c", "r", "o" })
