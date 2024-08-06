-- [[
-- NeoVim Builtin Options.
-- Reference: https://neovim.io/doc/user/quickref.html#option-list
-- ]]

local o = vim.o

o.autoindent = true -- take indent for new line from previous line
o.autoread = true -- autom. read file when changed outside of Vim
o.autowrite = false -- automatically write file if changed
o.background = "dark" -- "dark" or "light", used for highlight colors
o.backspace = "indent,eol,start" -- how backspace works at start of line
o.backup = false -- keep backup file after overwriting a file
o.buflisted = false -- whether the buffer shows up in the buffer list
o.clipboard = "unnamedplus" -- use the clipboard as the unnamed register
o.cmdheight = 1 -- number of lines to use for the command-line
o.completeopt = "menu,menuone,noselect" -- options for Insert mode completion
o.confirm = true -- ask what to do about unsaved/read-only files
o.copyindent = true -- make 'autoindent' use existing indent structure
o.cursorcolumn = false -- highlight the screen column of the cursor
o.cursorline = true -- highlight the screen line of the cursor
o.cursorlineopt = "both" -- settings for 'cursorline'
o.expandtab = true -- use spaces when <Tab> is inserted
o.hlsearch = true -- highlight matches with last search pattern
o.icon = true -- let Vim set the text of the window icon
o.ignorecase = true -- ignore case in search patterns
o.linebreak = false -- wrap long lines at a blank
o.mouse = "a" -- enable the use of mouse clicks
o.mousehide = true -- hide mouse pointer while typing
o.number = true -- print the line number in front of each line
o.pumheight = 8 -- maximum number of items to show in the popup menu
o.relativenumber = true -- show relative line number in front of each line
o.scrolloff = 8 -- minimum nr. of lines above and below cursor
o.shiftround = true -- round indent to multiple of shiftwidth
o.shiftwidth = 2 -- number of spaces to use for (auto)indent step
o.showmode = false -- Dont show mode since we have a statusline
o.sidescrolloff = 8 -- Columns of context
o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
o.smartcase = true -- Don't ignore case with capitals
o.smartindent = true -- Insert indents automatically
o.splitbelow = true -- Put new windows below current
o.splitkeep = "screen" -- determines scroll behavior for split windows
o.splitright = true -- Put new windows right of current
o.tabstop = 2 -- Number of spaces tabs count for
o.termguicolors = true -- enable 24-bit RGB color in the TUI
o.swapfile = false -- whether to use a swapfile for a buffer
o.timeoutlen = 300 -- time out time in milliseconds
o.title = true --  let Vim set the title of the window
o.updatetime = 200 -- after this many milliseconds flush swap file
o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
o.wildmode = "longest:full,full" -- Command-line completion mode
o.winminwidth = 5 -- Minimum window width
o.wrap = false -- long lines wrap and continue on the next line
