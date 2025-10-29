require("nvchad.mappings")

-- add yours here

local map = function(mode, key, func, desc, silent)
  vim.keymap.set(
    mode,
    key,
    func,
    { desc = desc or "", silent = silent or false }
  )
end

map("n", ";", ":", "CMD enter command mode")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>e", ":NvimTreeToggle<CR>", "Toggle NvimTree", true)

map("n", "<leader>qq", ":qa<CR>", "Quit NeoVim")

-- Clear Highlights
map("n", "<Esc>", "cmd>nohlsearch<CR>")

-- Exit Terminal Mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal Mode")

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
