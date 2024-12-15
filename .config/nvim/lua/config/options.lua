-- Neovim Default Options
local tab = 2

vim.o.autoread = true -- autom. read file when changed outside of Vim
vim.o.background = "dark" -- "dark" or "light", used for highlight colors
vim.o.backspace = "indent,eol,start" -- how backspace works at start of line
vim.o.backup = false -- keep backup file after overwriting a file
vim.o.clipboard = "unnamedplus" -- use the clipboard as the unnamed register
vim.o.cmdheight = 1 -- number of lines to use for the command-line
vim.o.confirm = true -- ask what to do about unsaved/read-only files
vim.o.cursorline = true -- highlight the screen line of the cursor
vim.o.expandtab = true -- use spaces when <Tab> is inserted
vim.o.icon = true -- let Vim set the text of the window icon
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.linebreak = false -- wrap long lines at a blank
vim.o.mouse = "a" -- enable the use of mouse clicks
vim.o.mousehide = true -- hide mouse pointer while typing
vim.o.number = true -- print the line number in front of each line
vim.o.pumheight = 8 -- maximum number of items to show in the popup menu
vim.o.relativenumber = true -- show relative line number in front of each line
vim.o.showmode = false -- message on status line to show current mode
vim.o.signcolumn = "yes" -- when and how to display the sign column
vim.o.smartcase = true -- no ignore case when pattern has uppercase
vim.o.softtabstop = tab -- number of spaces that <Tab> uses while editing
vim.o.splitbelow = true -- new window from split is below the current one
vim.o.splitright = true -- new window is put right of the current one
vim.o.smarttab = true -- use 'shiftwidth' when inserting <Tab>
vim.o.shiftround = true -- round indent to multiple of shiftwidth
vim.o.shiftwidth = tab -- number of spaces to use for (auto)indent step
vim.o.swapfile = false -- whether to use a swapfile for a buffer
vim.o.tabstop = tab -- number of spaces that <Tab> in file uses
vim.o.termguicolors = true -- enable 24-bit RGB color in the TUI
vim.o.timeoutlen = 250 -- time out time in milliseconds
vim.o.title = true -- let Vim set the title of the window
vim.o.updatetime = 300 -- after this many milliseconds flush swap file
vim.o.wrap = false -- long lines wrap and continue on the next line

-- Searching
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.infercase = true

-- Settings for Snacks
vim.o.statuscolumn = ""

-- Recommened Settings for Edgy.nvim
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

vim.o.showmatch = true -- show matching brackets / parenthesis
