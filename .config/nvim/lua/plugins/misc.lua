local trouble_ok, trouble = pcall(require, "trouble")
if trouble_ok then
  trouble.setup()

  vim.keymap.set(
    "n",
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<CR>",
    { desc = "Diagnostics" }
  )
end
