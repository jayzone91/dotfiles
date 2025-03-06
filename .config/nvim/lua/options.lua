local indent = 2
local opt = vim.opt

opt.backspace = { "indent", "eol", "start" }
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.cursorcolumn = false
opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.hidden = true -- enable background buffers
opt.hlsearch = true -- highlight found searches
opt.ignorecase = true
opt.inccommand = "split" -- get a preview of replacements
opt.incsearch = true -- show the match while typing
opt.joinspaces = false -- no double spaces with join
vim.o.lazyredraw = true
opt.linebreak = true -- stop words being broken on wrap
opt.number = true -- show line numbers
opt.listchars = { tab = " ", trail = "·", nbsp = "%" }
opt.list = true -- show some invisible characters
vim.o.shortmess = vim.o.shortmess .. "S" -- stops display of currentsearch match in cmdline aera
opt.equalalways = true -- make windows the same width when closing one
opt.cursorlineopt = "both" -- should get cursorline in number too
opt.expandtab = true
opt.shiftwidth = indent
opt.softtabstop = indent
opt.tabstop = indent
opt.showmode = false -- don´t display mode
opt.scrolloff = 8 -- lines of context
opt.sidescrolloff = 8 -- columns of context
opt.signcolumn = "yes:1" -- always show signcolumns
opt.smartcase = true -- don´t ignore case with capitals
opt.spelllang = { "de_de", "en_gb" }
opt.splitbelow = true -- put new windows below current
opt.splitright = true -- put new windows right of current
opt.termguicolors = true
opt.title = true
vim.g.markdown_fences_languages =
  { "html", "javascript", "typescript", "css", "lua", "scss", "vim" }
vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
opt.wrap = false
opt.mouse = "a"
opt.guicursor =
  "n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"
opt.undofile = false
opt.jumpoptions = "view"
opt.timeoutlen = 300
opt.cpoptions:append(">")
opt.nrformats:append("alpha")
opt.ph = 15
opt.cmdheight = 0
opt.virtualedit = "block"
vim.g.editorconfig = false

-- this is global setting for diagnostics
vim.o.updatetime = 250
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
