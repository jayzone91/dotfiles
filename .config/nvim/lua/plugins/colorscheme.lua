return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		ebaled = false,
		-- config = function()
		-- 	vim.cmd([[colorscheme rose-pine]])
		-- end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				variant = "default",
				transparent = false,
				italic_comments = true,
				hide_fillchars = true,
				borderless_pickers = true,
				terminal_colors = true,
				cache = true,
				extensions = {
					cmp = true,
					lazy = true,
					markdown = true,
					snacks = true,
					rainbow_delimiters = true,
					telescope = true,
					whichkey = true,
					trouble = true,
				},
			})

			vim.cmd([[colorscheme cyberdream]])
		end,
	},
}
