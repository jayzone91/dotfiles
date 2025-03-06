return {
	{ "folke/lazy.nvim", version = "*" },
	{ "wakatime/vim-wakatime", lazy = false },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
	},
	{
		"m4xshen/smartcolumn.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"cappyzawa/trim.nvim",
		event = "VeryLazy",
		opts = {
			ft_blocklist = { "markdown" },
		},
	},
	{
		"tpope/vim-sleuth",
		event = "VeryLazy",
	},
	{ "lewis6991/gitsigns.nvim", opts = {} },
}
