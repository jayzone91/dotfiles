local map = function(mode, key, func, desc)
  vim.keymap.set(mode, key, func, { desc = desc })
end

map("n", "<leader>qq", ":qa<cr>", "")
map("n", "<c-s>", ":w<CR>", "Save Buffer")
map({ "n", "i" }, "<C-s>", "<Esc>:w<CR>", "Buffer speichern")

map("n", "<leader>ss", ":vsplit<CR>", "Split Vertical")
map("n", "<leader>sv", ":split<CR>", "Split Horziontal")
