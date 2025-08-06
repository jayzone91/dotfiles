local lspserver = {
	lua_ls = {},
	tailwindcss = {
		filetypes_exclude = { "markdown" },
	},
	gopls = {
		settings = {
			gopls = {
				gofumpt = true,
				codelenses = {
					gc_details = false,
					generate = true,
					regenerate_cgo = true,
					run_govulncheck = true,
					test = true,
					tidy = true,
					upgrade_dependencies = true,
					vendor = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				analyses = {
					nilness = true,
					unusedparams = true,
					unusedwrite = true,
					useany = true,
				},
				usePlaceholders = true,
				completeUnimported = true,
				staticcheck = true,
				directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
				semanticTokens = true,
			},
		},
	},
	jsonls = {
		on_new_config = function(new_config)
			new_config.settings.json.schemas = new_config.settings.json.schemas or {}
			vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
		end,
		settings = {
			json = {
				format = {
					enable = true,
				},
				validate = { enable = true },
			},
		},
	},
	vtsls = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		settings = {
			complet_function_call = true,
			vtsls = {
				enableMoveToFileCodeAction = true,
				autoUseWorkspaceTsdk = true,
				experimental = {
					maxInlayHintLength = 30,
					completion = {
						enableServerSideFuzzyMatch = true,
					},
				},
			},
			typescript = {
				updateImportsOnFileMove = { enabled = "always" },
				suggest = {
					completeFuncionCalls = true,
				},
				inlayHints = {
					enumMemberVales = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					parameterNames = { enabled = "literals" },
					parameterTypes = { enabled = true },
					propertyDeclarationTypes = { enabled = true },
					variableTypes = { enabled = false },
				},
			},
		},
	},
}

local formatter = {
	"stylua",
	"goimports",
	"gofumpt",
	"prettier",
}

return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			{
				"b0o/SchemaStore.nvim",
				lazy = true,
				version = false, -- last release is way too old
			},
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
