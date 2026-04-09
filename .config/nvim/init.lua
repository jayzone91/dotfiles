-- Check if Neovide extists
if vim.g.neovide then
	require("config/neovide")
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load default options
require("config/options")
-- Install Plugins


-- Configure Plugins


-- Load Keymaps
require("config/keymaps")
-- Load autocmds
require("config/autocmds")

