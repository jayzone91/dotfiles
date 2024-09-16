return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
	opts = {},
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<CR>",
			desc = "Diagnostics (trouble)"
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle folter.buf=0<CR>",
			desc = "Buffer Diagnostics (trouble)"
		},
	}
}
