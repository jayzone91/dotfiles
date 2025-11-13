local map = function(mode, key, func, desc)
  return vim.keymap.set(mode, key, func, { desc = desc })
end

-- Clear Highlights
map("n", "<Esc>", "cmd>nohlsearch<CR>")

-- Exit Terminal Mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal Mode")

map("n", "<leader>qq", ":qa<cr>", "Exit NeoVim")
map("n", "<c-s>", ":w<CR>", "Save Buffer")
map({ "n", "i" }, "<C-s>", "<Esc>:w<CR>", "Buffer speichern")

map("n", "<leader>ss", ":vsplit<CR>", "Split Vertical")
map("n", "<leader>sv", ":split<CR>", "Split Horziontal")

map("n", "<c-left>", "<c-w><c-h>", "Move focus to left window")
map("n", "<c-h>", "<c-w><c-h>", "Move focus to left window")

map("n", "<c-right>", "<c-w><c-l>", "Move focus to right window")
map("n", "<c-l>", "<c-w><c-l>", "Move focus to right window")

map("n", "<c-up>", "<c-w><c-k>", "Move focus to upper window")
map("n", "<c-k>", "<c-w><c-k>", "Move focus to upper window")

map("n", "<c-down>", "<c-w><c-j>", "Move focus to lower window")
map("n", "<c-j>", "<c-w><c-j>", "Move focus to lower window")
