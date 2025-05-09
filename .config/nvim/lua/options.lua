local indent = 2

vim.o.shiftwidth = indent
vim.o.tabstop = indent
vim.o.expandtab = true

vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menu,menuone,noselect"

vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.linebreak = true
vim.o.inccommand = "nosplit"
vim.o.mouse = "a"
vim.o.pumblend = 10
vim.o.pumheight = 10
vim.o.scrolloff = 4
vim.o.shiftround = true
vim.o.signcolumn = "yes"
vim.o.sidescrolloff = 8
vim.o.smartindent = true
vim.o.splitkeep = "screen"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
vim.o.termguicolors = true
vim.o.wildmode = "longest:full,full"
vim.o.showmode = false
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.confirm = true
