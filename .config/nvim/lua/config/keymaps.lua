-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = function(mode, key, func, opts)
  opts = opts or {}
  opts.silent = true
  opts.noremap = true

  -- Delete Keymap if one exists
  pcall(vim.keymap.del, mode, key)

  vim.keymap.set(mode, key, func, opts)
end

-- Better Up and Down
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Duplicate Lines
map("n", "<leader>k", "yyP", { desc = "Duplicate Line Up" })
map("n", "<leader><Up>", "yyP", { desc = "Duplicate Line Up" })
map("n", "<leader>j", "yyp", { desc = "Duplicate Line Down" })
map("n", "<leader><Down>", "yyp", { desc = "Duplicate Line Down" })

-- Select all
map("n", "<c-a>", "ggVG", { desc = "Select all" })

-- Exit Terminal Mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal Mode" })

map("n", "<leader>qq", ":qa<cr>", { desc = "Exit NeoVim" })
map("n", "<c-s>", ":w<CR>", { desc = "Save Buffer" })
map({ "n", "i" }, "<C-s>", "<Esc>:w<CR>", { desc = "Buffer speichern" })

map("n", "<leader>ss", ":vsplit<CR>", { desc = "Split Vertical" })
map("n", "<leader>sv", ":split<CR>", { desc = "Split Horziontal" })

map("n", "<c-left>", "<c-w><c-h>", { desc = "Move focus to left window" })
map("n", "<c-h>", "<c-w><c-h>", { desc = "Move focus to left window" })

map("n", "<c-right>", "<c-w><c-l>", { desc = "Move focus to right window" })
map("n", "<c-l>", "<c-w><c-l>", { desc = "Move focus to right window" })

map("n", "<c-up>", "<c-w><c-k>", { desc = "Move focus to upper window" })
map("n", "<c-k>", "<c-w><c-k>", { desc = "Move focus to upper window" })

map("n", "<c-down>", "<c-w><c-j>", { desc = "Move focus to lower window" })
map("n", "<c-j>", "<c-w><c-j>", { desc = "Move focus to lower window" })
