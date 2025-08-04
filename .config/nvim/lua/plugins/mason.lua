local lspserver = {
	lua_ls = {},
}

local formatter = {
	"stylua",
}

return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = function()
			local ensure_installed = {}
			for server, _ in pairs(lspserver) do
				table.insert(ensure_installed, server)
			end

			return {
				automatic_enable = true,
				ensure_installed = ensure_installed,
			}
		end,
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for server, config in pairs(lspserver) do
				config = config or {}
				vim.tbl_extend("force", { capabilities = capabilities }, config)
				vim.lsp.config(server, config)
			end
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = formatter,
			auto_update = true,
		},
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},
}
