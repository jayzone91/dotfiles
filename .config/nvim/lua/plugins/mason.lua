return {
	"williamboman/mason.nvim",
	dependencies = {
		-- Install Formatters and Linters
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Install LSP Servers
		"williamboman/mason-lspconfig.nvim",
		-- Schema information
      		"b0o/SchemaStore.nvim",
	},
	config = function()
		require("config.plugins.mason").setup()
	end,
}
