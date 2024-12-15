-- Keymaps for standard Neovim Functions

vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit Neovim" })

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
