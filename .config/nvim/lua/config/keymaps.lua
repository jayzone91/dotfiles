local function map(mode, key, func, desc)
  return vim.keymap.set(mode, key, func, {desc = desc})
end

map("n", "<leader>qq", ":qa<CR>", "Neovim beenden")
