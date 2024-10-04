-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = function(mode, key, func, opts)
  vim.keymap.set(mode, key, func, opts)
end

-- Duplicate Lines
map("n", "<leader><down>", "Yp", { desc = "Duplicate Line Down" })
map("n", "<leader>j", "Yp", { desc = "Duplicate Line Down" })
map("n", "<leader><up>", "YP", { desc = "Duplicate Line Up" })
map("n", "<leader>k", "YP", { desc = "Duplicate Line Up" })

-- Move Lines
map("n", "<a-down>", "<cmd>m .+1<cr>==")
map("n", "<a-j>", "<cmd>m .+1<cr>==")
map("n", "<a-up>", "<cmd>m .-2<cr>==")
map("n", "<a-k>", "<cmd>m .-2<cr>==")

-- Move windows using the CTRL key
map("n", "<c-h>", "<C-w>h", { remap = true })
map("n", "<c-left>", "<C-w>h", { remap = true })
map("n", "<c-j>", "<C-w>j", { remap = true })
map("n", "<c-down>", "<C-w>j", { remap = true })
map("n", "<c-k>", "<C-w>k", { remap = true })
map("n", "<c-up>", "<C-w>k", { remap = true })
map("n", "<c-l>", "<C-w>l", { remap = true })
map("n", "<c-right>", "<C-w>l", { remap = true })

-- split Window
map("n", "<leader>ss", "<C-w>s", { desc = "Split Screen horizontal" })
map("n", "<leader>sv", "<C-w>v", { desc = "Split Screen vertical" })
map("n", "<leader>se", "<C-w>=", { desc = "Make Split equal size" })

-- Select All
map({ "i", "n" }, "<C-a>", "<esc>gg<S-v>G")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
