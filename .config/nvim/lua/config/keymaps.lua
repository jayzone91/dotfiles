if vim.g.neovide then
	vim.keymap.set("n","<C-c>", '"+y', {desc = "Copy to Clipboard"})
	vim.keymap.set("i", "<C-c>", '<Esc>"+yi', {desc = "Copy to Clipboard"})
	vim.keymap.set("n","<C-v>", '"+p', {desc = "Paste from Clipboard"})
	vim.keymap.set("i", "<C-v>", '<Esc>"+pa', {desc = "Paste from Clipboard"})
end


vim.keymap.set("n", "<C-s>", ":w<CR>", {desc = "Save File"})
vim.keymap.set("i", "<C-S>", "<Esc>:w<Cr>", {desc ="Save File"})

