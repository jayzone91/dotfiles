return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "regex" },
		sync_install = false,
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
