local indent = 2

local o = vim.o

o.background = "dark"
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)
o.breakindent = true
o.signcolumn = "yes"
o.completeopt = "menu,menuone,noinsert"
o.confirm = true
o.expandtab = true
o.ignorecase = true
o.mouse = "a"
o.number = true
o.scrolloff = 8
o.shiftwidth = indent
o.showmode = false
o.sidescrolloff = 8
o.smartcase = true
o.smartindent = true
o.smarttab = true
o.softtabstop = indent
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = indent
o.termguicolors = true
o.timeoutlen = 200
o.title = true
o.updatetime = 250
o.wrap = false
o.cursorline = true
o.inccommand = "split"
o.laststatus = 3
