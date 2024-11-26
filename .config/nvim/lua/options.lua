local indent = 2
local opt = vim.opt
opt.backspace = { "indent", "eol", "start" }
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.cursorcolumn = true
opt.encoding = "utf-8"
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.incsearch = true
opt.joinspaces = false
vim.o.lazyredraw = true
opt.linebreak = true
opt.number = true
opt.listchars = { tab = " ", trail = "·", nbsp = "%" }
opt.list = true
vim.o.shortmess = vim.o.shortmess .. "S"
opt.equalalways = true
opt.cursorlineopt = "both"

opt.expandtab = true
opt.shiftwidth = indent
opt.softtabstop = indent
opt.tabstop = indent

opt.showmode = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.spelllang = { "de_de", "en_us" }
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.title = true

vim.g.markdown_fenced_languages = { "html", "javascript", "typescript" }
vim.o.whichwrap = vim.o.whichwrap .. "<,>"
opt.wrap = false

opt.mouse = "a"
opt.guicursor =
  "n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"
opt.undodir = vim.fn.stdpath("config") .. "/undo"
opt.undofile = true
vim.notify = require("notify")
opt.jumpoptions = "view"
opt.timeoutlen = 300
opt.cpoptions:append(">")
opt.nrformats:append("alpha")

opt.ph = 15
opt.cmdheight = 0
opt.virtualedit = "block"
vim.g.editorconfig = false

local api = vim.api

local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = yankGrp,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight yank",
})

local cursorGrp = api.nvim_create_augroup("CursorColumn", { clear = true })
api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  command = "set nocursorcolumn",
  group = cursorGrp,
})

vim.o.autoread = true
api.nvim_create_autocmd(
  { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" },
  {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
  }
)

vim.o.updatetime = 250
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
