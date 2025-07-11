vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.scrolloff = 3

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.g.lua_snippets_path = vim.fn.stdpath("config") .. "/lua/snippets/"
vim.cmd("au BufRead,BufNewFile *.templ setfiletype templ")
local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.templ" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, "filetype", "templ")
  end,
})

vim.opt.rtp:prepend(lazypath)

-- Set highlight on Search
vim.o.hlsearch = false

-- Make line numbers default
vim.o.number = true

-- Tabs vs spaces
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between os and neovim
vim.o.clipboard = "unnamedplus"

-- enable break indent
vim.o.breakindent = true

-- save undo history
vim.o.undofile = true

-- case-insensitive searching unless \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- keep signcolumn on by default
vim.o.signcolumn = "yes"

-- decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- set terminal gui colors to true
vim.o.termguicolors = true

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data")
    .. "/mason/bin"
    .. (is_windows and ";" or ":")
    .. vim.env.PATH

require("lazy").setup("plugins")
