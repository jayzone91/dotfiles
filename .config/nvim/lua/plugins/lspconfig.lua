return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
						{ path = "snacks.nvim",        words = { "Snacks" } },
					},
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local lsp = require("plugins.configs.lsp")

			for server, config in pairs(lsp) do
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
					on_attach = function(client)
						client.server_capabilities.document_formatting = false
					end,
				}, config)

				lspconfig[server].setup(config)
			end

			lspconfig.templ.setup({})

			-- Keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client name")
					local settings = lsp[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
					vim.keymap.set("n", "gd", function()
						Snacks.picker.lsp_definitions()
					end, { desc = "GoTo Definition" })
					vim.keymap.set("n", "gr", function()
						Snacks.picker.lsp_references()
					end, { desc = "References" })
				end,
			})
		end,
	},
}
