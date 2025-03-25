local indent = 2

vim.o.numberwidth = 3
vim.o.autoindent = true
vim.o.autoread = true
vim.o.background = "dark"
vim.o.backspace = "indent,eol,start"
vim.o.backup = false

-- sync Clipboard between OS and Neovim.
-- Schedule the settings after "UIEnter" because it can increase start-up time.
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.cmdheight = 1
vim.o.completeopt = "menu,menuone,noselect"
vim.o.confirm = true
vim.o.cursorcolumn = false
vim.o.cursorline = true
vim.o.cursorlineopt = "line,number"
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.pumblend = 15
vim.o.pumheight = 8
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.shiftround = true
vim.o.shiftwidth = indent
vim.o.showmode = false
vim.o.signcolumn = "yes:1"
vim.o.statuscolumn = "%l%s"
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
vim.o.updatetime = 350
vim.o.wrap = false

-- Disable Shada error on windows
vim.o.shadafile = "NONE"
