return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	lazy = false,
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		{ "williamboman/mason-lspconfig.nvim", opts = {} },
	},
	config = function()
		local server_list = require("config.software")

		local ensure_installed = {}

		for server, _ in pairs(server_list.lsp) do
			table.insert(ensure_installed, server)
		end
		for _, formatter in pairs(server_list.formatter) do
			for i = 1, #formatter, 1 do
				table.insert(ensure_installed, formatter[i])
			end
		end

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			auto_update = true,
			run_on_start = true,
			start_delay = 3000, -- 3 Second Delay
			debounce_hour = 5,
			integrations = {
				["mason-lspconfig"] = true,
				["mason-null-ls"] = false,
				["mason-nvim-dap"] = false,
			},
		})
	end,
}
