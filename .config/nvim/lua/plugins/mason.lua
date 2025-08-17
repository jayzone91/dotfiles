local lspserver = {
	lua_ls = {},
	dockerls = {},
	prismals = {},
	docker_compose_language_service = {},
	tailwindcss = {
		filetypes_exclude = { "markdown" },
	},
	pyright = {},
	ruff = {
		cmd_env = { RUFF_TRACE = "messages" },
		init_options = {
			settings = {
				logLevel = "error",
			},
		},
	},
	marksman = {},
	svelte = {
		capabilities = {
			workspace = {
				didChangeWatchedFiles = vim.fn.has("nvim-0.10") == 0 and { dynamicRegistration = true },
			},
		},
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
	yamlls = {
		capabilities = {
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				},
			},
		},
		on_new_config = function(new_config)
			new_config.settings.yaml.schemas = vim.tbl_deep_extend(
				"force",
				new_config.settings.yaml.schemas or {},
				require("schemastore").yaml.schemas()
			)
		end,
		settings = {
			redhat = { telemetry = { enabled = true } },
			yaml = {
				keyOrdering = false,
				format = {
					enable = true,
				},
				validate = true,
				schemastore = {
					enable = false,
					url = "",
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
	"hadolint",
	"markdownlint-cli2",
	"markdown-toc",
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

			local config = { capabilities = capabilities }

			vim.lsp.enable("nushell")
			vim.lsp.enable("autohotkey_lsp")
			vim.lsp.enable("ruby_lsp")

			vim.lsp.config("nushell", config)
			vim.lsp.config("autohotkey_lsp", config)
			vim.lsp.config("ruby_lsp", config)
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
