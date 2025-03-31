return {
	"jayzone91/present.nvim",
	ft = "markdown",
	config = function()
		vim.keymap.set("n", "<leader>ms", ":PresentStart<CR>", { desc = "Start MD Presentation" })
	end,
}
