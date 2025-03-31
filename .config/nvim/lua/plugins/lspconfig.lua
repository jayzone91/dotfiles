return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ path = "snacks.nvim", words = { "Snacks" } },
				},
			},
		},
	},
	config = function()
		require("lsp_hover").setup({
			---@diagnostic disable-next-line:missing-fields
			["^lua_ls"] = {
				border_hl = "Special",
			},
		})

		local mason_config = require("config.mason-config")
		local has_blink, blink = pcall(require, "blink.cmp")
		local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend("force", {}, {
			vim.lsp.protocol.make_client_capabilities(),
			has_blink and blink.get_lsp_capabilities() or {},
			has_cmp and cmp.default_capabilities() or {},
		})

		for lsp, config in pairs(mason_config.lsp) do
			if type(config) ~= "table" then
				config = {}
			end

			vim.tbl_deep_extend("force", {
				capabilities = capabilities,
			}, config)
			require("lspconfig")[lsp].setup(config)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(_)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
			end,
		})

		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			virtual_lines = true,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
				numhl = {
					[vim.diagnostic.severity.WARN] = "WarningMsg",
					[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
					[vim.diagnostic.severity.HINT] = "DiagnosticHint",
				},
			},
		})
	end,
}
