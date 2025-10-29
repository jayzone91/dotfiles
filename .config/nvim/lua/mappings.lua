require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map(
  "n",
  "<leader>e",
  ":NvimTreeToggle<CR>",
  { desc = "Toggle NvimTree", silent = true }
)

map("n", "<leader>qq", ":qa<CR>", { desc = "Quit NeoVim", silent = true })
