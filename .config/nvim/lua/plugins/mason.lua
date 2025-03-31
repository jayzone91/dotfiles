return {
	"williamboman/mason.nvim",
	dependencies = {
		-- Install all the Packages
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Optional Dependencies for Mason-Tool-Installer
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local mason_config = require("config.mason-config")

		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local ensure_installed = {}

		for server, _ in pairs(mason_config.lsp) do
			table.insert(ensure_installed, server)
		end
		for _, formatter in pairs(mason_config.formatter) do
			for i = 1, #formatter, 1 do
				table.insert(ensure_installed, formatter[i])
			end
		end
		for _, linter in pairs(mason_config.linter) do
			for i = i, #linter, 1 do
				table.insert(ensure_installed, formatter[i])
			end
		end

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			auto_update = true,
			run_on_start = true,
			start_delay = 3000, -- 3 Second delay
			debounce_hour = 5, -- at least 5 hours between attempts to install/update
			integrations = {
				["mason-lspconfig"] = true,
				["mason-null-ls"] = false,
				["mason-nvim-dap"] = true,
			},
		})
	end,
}
