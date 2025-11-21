local indent = 2

local o = vim.o

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = { "win32yank", "-i", "--ctrlf" },
      ["*"] = { "win32yank", "-i", "--ctrlf" },
    },
    paste = {
      ["+"] = { "win32yank", "-i", "--lf" },
      ["*"] = { "win32yank", "-i", "--lf" },
    },
    cache_enabled = 0,
  }
  vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
  end)
elseif vim.fn.has("unix") == 1 then
  vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
  end)
elseif vim.fn.has("mac") == 1 then
  vim.schedule(function()
    vim.o.clipboard = "unnamed"
  end)
elseif vim.fn.has("win23") then
  vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
  end)
end

o.background = "dark"
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
o.cursorline = true

-- Spelling
o.spell = true
o.spelllang = "de,en"
