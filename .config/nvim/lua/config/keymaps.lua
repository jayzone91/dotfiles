local function map(mode, key, func, opts)
  vim.keymap.set(mode, key, func, opts)
end

map("n", "<leader>qq", ":qa<CR>", { desc = "Quit Neovim" })

-- Save with CTRL+S
map("n", "<C-S>", ":w<CR>", { desc = "Save current buffer" })
map("i", "<C-S>", "<esc>:w<CR>", { desc = "Save current buffer" })

-- better up/down
map(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true }
)
map(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true }
)
map(
  { "n", "x" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { desc = "Up", expr = true, silent = true }
)
map(
  { "n", "x" },
  "<Up>",
  "v:count == 0 ? 'gk' : 'k'",
  { desc = "Up", expr = true, silent = true }
)

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map(
  "n",
  "n",
  "'Nn'[v:searchforward].'zv'",
  { expr = true, desc = "Next Search Result" }
)
map(
  "x",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next Search Result" }
)
map(
  "o",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next Search Result" }
)
map(
  "n",
  "N",
  "'nN'[v:searchforward].'zv'",
  { expr = true, desc = "Prev Search Result" }
)
map(
  "x",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev Search Result" }
)
map(
  "o",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev Search Result" }
)

map("t", "<esc>", "<C-\\><C-N>", { desc = "Easy Leave Terminal Mode" })

-- Duplicate Lines
map("n", "<leader>k", "YP", { desc = "Duplicate Line Up" })
map("n", "<leader><up>", "YP", { desc = "Duplicate Line Up" })
map("n", "<leader>l", "Yp", { desc = "Duplicate Line down" })
map("n", "<leader><down>", "Yp", { desc = "Duplicate Line down" })

-- Split screen
map("n", "<leader>ss", ":vsplit<CR>", { desc = "Split Screen" })

local function has_win()
  return vim.uv.os_uname().sysname:find("Windows") ~= nil
end
-- Change active window
if has_win() then
  map("n", "<C-Left>", ":wincmd h<CR>")
  map("n", "<C-Right>", ":wincmd l<CR>")
  map("n", "<C-Up>", ":wincmd k<CR>")
  map("n", "<C-Down>", ":wincmd j<CR>")
else
  map("n", "<M-Left>", ":wincmd h<CR>")
  map("n", "<M-Right>", ":wincmd l<CR>")
  map("n", "<M-Up>", ":wincmd k<CR>")
  map("n", "<M-Down>", ":wincmd j<CR>")
end
