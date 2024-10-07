-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--- Map a key combination to a command
---@param modes string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? table
local map = function(modes, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if type(modes) == "string" then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    vim.keymap.set(mode, lhs, rhs, options)
  end
end

map("n", "<leader>ss", "<C-w>s", { desc = "Split Screen horizontal" })
map("n", "<leader>sv", "<C-w>v", { desc = "Split Screen vertical" })
map("n", "<leader>se", "<C-w>=", { desc = "Make Split equal size" })
map("n", "<leader><up>", "YP", { desc = "Duplicate Line Up" })
map("n", "<leader><down>", "Yp", { desc = "Duplicate Line Down" })
map("n", "<a-down>", "<cmd>m .+1>CR>==")
map("n", "<a-up>", "<cmd>m .-2<CR>==")

map("n", "<c-h>", "<C-w>h", { remap = true })
map("n", "<c-left>", "<C-w>h", { remap = true })
map("n", "<c-j>", "<C-w>j", { remap = true })
map("n", "<c-down>", "<C-w>j", { remap = true })
map("n", "<c-k>", "<C-w>k", { remap = true })
map("n", "<c-up>", "<C-w>k", { remap = true })
map("n", "<c-l>", "<C-w>l", { remap = true })
map("n", "<c-right>", "<C-w>l", { remap = true })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
