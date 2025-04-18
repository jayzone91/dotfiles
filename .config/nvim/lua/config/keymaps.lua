local function map(mode, key, fn, desc)
	return vim.keymap.set(mode, key, fn, { desc = desc or "" })
end

map("n", "<leader>qq", ":qa<CR>", "Quit Neovim")
-- Save with CTRL+S
map({ "i", "x", "n", "s" }, "<C-S>", "<cmd>w<CR><esc>", "Save current buffer")

-- Duplicate Lines
map("n", "<leader>k", "YP", "Duplicate Line Up")
map("n", "<leader><up>", "YP", "Duplicate Line Up")
map("n", "<leader>l", "Yp", "Duplicate Line down")
map("n", "<leader><down>", "Yp", "Duplicate Line down")

-- Split screen
map("n", "<leader>ss", ":vsplit<CR>", "Split Screen Vertical")
map("n", "<leader>sv", ":split<CR>", "Split Screen Horizontal")

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

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Clear search and stop snippet on escape
vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map("t", "<esc>", "<C-\\><C-N>", "Easy Leave Terminal Mode")

-- Floating Terminal
vim.keymap.set("n", "<leader>t", "<cmd>Floaterminal<CR>", { desc = "Toggle Floating Terminal" })
