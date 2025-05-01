require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", "<leader>qq", ":qa<CR>", { desc = "Quit Neovim" })

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
map("n", "<leader>ss", ":vsplit<CR>", { desc = "Split Screen Vertical" })
map("n", "<leader>sv", ":split<CR>", { desc = "Split Screen Horizontal" })

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
  map("n", "<leader><left>", ":wincmd h<CR>")
  map("n", "<leader><right>", ":wincmd l<CR>")
end

vim.keymap.del("n", "<leader>e")
vim.keymap.del("n", "<leader>ff")
vim.keymap.del("n", "<leader>fh")
vim.keymap.del("n", "<leader>n")
vim.keymap.del("n", "<leader>wk")
vim.keymap.del("n", "<leader>wK")
vim.keymap.del("n", "<leader>fa")
-- vim.keymap.del("n", "<leader>th")
vim.keymap.del("n", "<leader>pt")
vim.keymap.del("n", "<leader>gt")
vim.keymap.del("n", "<leader>cm")
vim.keymap.del("n", "<leader>fz")
vim.keymap.del("n", "<leader>fo")
vim.keymap.del("n", "<leader>ma")
vim.keymap.del("n", "<leader>fb")
vim.keymap.del("n", "<leader>fw")
vim.keymap.del("n", "<leader>/")
vim.keymap.del("n", "<leader>ds")
vim.keymap.del("n", "<leader>fm")
vim.keymap.del("n", "<leader>ch")
vim.keymap.del("n", "<leader>rn")
vim.keymap.del("v", "<leader>/")
vim.keymap.del("x", "<leader>fm")

map("n", "<leader>e", function()
  Snacks.explorer.open({
    hidden = true,
    ignored = true,
    auto_close = true,
  })
end, { desc = "Open Explorer" })

map("n", "<leader>zz", function()
  Snacks.zen.zoom()
end, { desc = "Zen Mode" })

map("n", "<leader>zm", function()
  Snacks.zen()
end, { desc = "Zen Mode" })

map("n", "<leader><space>", function()
  Snacks.picker.buffers()
end, { desc = "Search Buffers" })

map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find Files" })

map("n", "<leader>fk", function()
  Snacks.picker.keymaps()
end, { desc = "Find Keymaps" })

map("n", "<leader>fg", function()
  Snacks.picker.grep()
end, { desc = "Live Grep" })

map("n", "<leader>fh", function()
  Snacks.picker.help()
end, { desc = "Find Help" })

map("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })

map("n", "gD", function()
  Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })

map("n", "gr", function()
  Snacks.picker.lsp_references()
end, { desc = "References" })

map("n", "gI", function()
  Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })

map("n", "gy", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })
