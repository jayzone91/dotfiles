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

-- Windows specific settings
if vim.uv.os_uname().sysname:find("Windows") ~= nil then
  vim.o.shell = "pwsh"
  vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned "
    .. "-Command [Console]::InputEncoding=[Console]::OutputEncoding"
    .. "=[System.Text.Encoding]::UTF8;$PSStyle.Formatting.Error = '';"
    .. "$PSStyle.Formatting.ErrorAccent = '';"
    .. "$PSStyle.Formatting.Warning = '';$PSStyle.OutputRendering = 'PlainText';"
  vim.opt.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exot $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
  vim.opt.shadafile = "NONE"
end
