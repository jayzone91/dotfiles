local indent = 2 -- the indentation
local opt = vim.opt -- to set options

opt.backspace = { "indent", "eol", "start" }
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.cursorcolumn = true
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
opt.wrap = true
opt.mouse = "a"
opt.guicursor =
  "n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"
opt.undodir = vim.fn.stdpath("config") .. "/undo"
opt.undofile = true
opt.jumpoptions = "view"
opt.timeoutlen = 300
opt.cpoptions:append(">")
opt.nrformats:append("alpha")
opt.ph = 15
opt.cmdheight = 0
opt.virtualedit = "block"
vim.g.editorconfig = false

local api = vim.api

-- Highlight on Yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = yankGrp,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight Yank",
})

-- show cursorline only on active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
})
api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  command = "set nocursorline",
  group = cursorGrp,
})

-- show cursorcol line only in active window
local cursorColGrp = api.nvim_create_augroup("CursorColumn", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorcolumn",
  group = cursorColGrp,
})
api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  command = "set nocursorcolumn",
  group = cursorColGrp,
})

-- auto reload files when modified externally
vim.o.autoread = true
vim.api.nvim_create_autocmd(
  { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" },
  {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
  }
)

local function augroup(name)
  return vim.api.nvim_create_augroup("jay_" .. name, { clear = true })
end

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit Buffer",
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- this is global setting for diagnostics
vim.o.updatetime = 250
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
