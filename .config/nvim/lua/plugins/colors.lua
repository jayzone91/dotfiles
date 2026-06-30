return {
	"Mofiqul/vscode.nvim",
	config = function()
		vim.o.background = "dark"

		require("vscode").setup({
			transparent = false,
			italic_comments = true,
			italic_inlayhints = true,
			underline_links = true,
			terminal_colors = true,
		})

		vim.cmd.colorscheme("vscode")
	end,
}
