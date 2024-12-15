-- Keymaps for standard Neovim Functions

vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit Neovim" })

-- Move normally between wrapped lines
vim.keymap.set(
  "n",
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
vim.keymap.set(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

-- Splits
vim.keymap.set(
  "n",
  "<leader>ss",
  "<C-W>s",
  { desc = "Split Screen Horizontal" }
)
vim.keymap.set("n", "<leader>sv", "<C-W>v", { desc = "Split Screen Vertical" })
vim.keymap.set("n", "<c-j>", "<C-w>j", { desc = "Jump to lower split" })
vim.keymap.set("n", "<c-k>", "<C-w>k", { desc = "Jump to upper split" })
vim.keymap.set("n", "<c-h>", "<C-w>h", { desc = "Jump to left split" })
vim.keymap.set("n", "<c-l>", "<C-w>l", { desc = "Jump to right split" })

-- Clean search highlights
vim.keymap.set("n", "<esc>", ":noh<CR>", { silent = true })

-- Duplicate Lines
vim.keymap.set("n", "<leader>k", "YP", { desc = "Duplicate Line Up" })
vim.keymap.set("n", "<leader><up>", "YP", { desc = "Duplicate Line Up" })
vim.keymap.set("n", "<leader>l", "Yp", { desc = "Duplicate Line down" })
vim.keymap.set("n", "<leader><down>", "Yp", { desc = "Duplicate Line down" })

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-terminal", { clear = true }),
  callback = function()
    vim.opt.number = false -- deactivate line numbers in terminal
    vim.opt.relativenumber = false -- deactivate relative line numbers in terminal
  end,
})

vim.keymap.set("n", "<leader>sf", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end, { desc = "Small Terminal Split" })

vim.keymap.set(
  "t",
  "<esc>",
  "<C-\\><C-N>",
  { desc = "Easy Leave Terminal Mode" }
)
