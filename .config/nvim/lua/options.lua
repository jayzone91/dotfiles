-- Neovim Options.
-- ref.: https://neovim.io/doc/user/quickref.html#option-list
vim.o.autoindent = true -- take indent for new line from previous line
vim.o.autoread = true -- autom. read file when changed outside of Vim
vim.o.background = "dark" -- "dark" or "light", used for highlight colors
vim.o.backspace = "indent,eol,start" -- how backspace works at start of line
vim.o.backup = false -- keep backup file after overwriting a file
vim.o.breakindent = false -- wrapped line repeats indent
-- Schedule the settings afer "UIEnter" because it can increase startuptime
vim.schedule(function()
  vim.o.clipboard = "unnamedplus" -- use the clipboard as the unnamed register
end)
vim.o.cmdheight = 1 -- number of lines to use for the command-line
vim.o.completeopt = "menu,menuone,noinsert" -- options for Insert mode completion
vim.o.confirm = true -- ask what to do about unsaved/read-only files
vim.o.copyindent = true -- make 'autoindent' use existing indent structure
vim.o.cursorline = true -- highlight the screen line of the cursor
vim.o.expandtab = true -- use spaces when <Tab> is inserted
vim.o.grepformat = "%f:%l:%c:%m" -- format of 'grepprg' output
vim.o.grepprg = "rg --vimgrep" -- program to use for ":grep"
vim.o.icon = true -- let Vim set the text of the window icon
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.incsearch = true -- highlight match while typing search pattern
vim.o.laststatus = 3 -- tells when last window has status lines
vim.o.linebreak = false -- wrap long lines at a blank
vim.o.mouse = "a" -- enable the use of mouse clicks
vim.o.mousehide = true -- hide mouse pointer while typing
vim.o.number = true -- print the line number in front of each line
vim.o.pumheight = 5 -- maximum number of items to show in the popup menu
vim.o.relativenumber = true -- show relative line number in front of each line
vim.o.scrolloff = 8 -- minimum nr. of lines above and below cursor
vim.o.shiftround = true -- round indent to multiple of shiftwidth
vim.o.shiftwidth = 2 -- number of spaces to use for (auto)indent step
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- list of flags, reduce length of messages
vim.o.showmode = false -- message on status line to show current mode
vim.o.signcolumn = "yes" -- when and how to display the sign column
vim.o.smartcase = true -- no ignore case when pattern has uppercase
vim.o.smartindent = true -- smart autoindenting for C programs
vim.o.smarttab = true -- use 'shiftwidth' when inserting <Tab>
vim.o.smoothscroll = true -- scroll by screen lines when 'wrap' is set
vim.o.softtabstop = 2 -- number of spaces that <Tab> uses while editing
vim.o.splitbelow = true -- new window from split is below the current one
vim.o.splitkeep = "screen" -- determines scroll behavior for split windows
vim.o.splitright = true -- new window is put right of the current one
vim.o.swapfile = false -- whether to use a swapfile for a buffer
vim.o.tabstop = 2 -- number of spaces that <Tab> in file uses
vim.o.termguicolors = true -- enable 24-bit RGB color in the TUI
vim.o.timeout = true -- time out on mappings and key codes
vim.o.timeoutlen = 300 -- time out time in milliseconds
vim.o.title = true --  let Vim set the title of the window
vim.o.updatetime = 200 -- after this many milliseconds flush swap file
vim.o.wildmode = "longest:full,full" -- mode for 'wildchar' command-line expansion
vim.o.wrap = false -- long lines wrap and continue on the next line

-- Custom Filetypes
vim.filetype.add({
  pattern = {
    [".*/%.github/dependabot.yml"] = "dependabot",
    [".*/%.github/dependabot.yaml"] = "dependabot",
    [".*/%.github/workflows[%w/]+.*%.yml"] = "gha",
    [".*/%.github/workflows/[%w/]+.*%.yaml"] = "gha",
  },
})

vim.treesitter.language.register("yaml", "gha")
vim.treesitter.language.register("yaml", "dependabot")
