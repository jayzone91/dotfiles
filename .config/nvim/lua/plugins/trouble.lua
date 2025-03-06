return {
	"folke/trouble.nvim",
	opts = {},
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<CR>",
			desc = "diagnostics (trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
	},
}
