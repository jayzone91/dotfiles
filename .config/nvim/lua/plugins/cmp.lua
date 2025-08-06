return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"onsails/lspkind.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
		"roobert/tailwindcss-colorizer-cmp.nvim",
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		local cmp = require("cmp")

		vim.opt.completeopt = { "menu", "menuone", "noselect" }
		vim.opt.shortmess:append("c")

		local lspkind = require("lspkind")
		lspkind.init({
			symbol_map = {
				Copilot = "",
			},
		})

		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

		local kind_formatter = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
				gh_issues = "[issues]",
				tn = "[TabNine]",
				eruby = "[erb]",
			},
		})

		require("tailwindcss-colorizer-cmp").setup({
			color_square_width = 2,
		})

		cmp.setup({
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "lazydev", group_index = 0 },
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
			}, {
				{ name = "buffer" },
			}),
			formatting = {
				fields = { "abbr", "kind", "menu" },
				expandable_indicator = true,
				format = function(entry, vim_item)
					vim_item = kind_formatter(entry, vim_item)
					vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

					return vim_item
				end,
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
	end,
}
