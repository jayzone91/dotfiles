return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters = {
			["markdown-toc"] = {
				condition = function(_, ctx)
					for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
						if line:find("<!%-%- toc %-%->") then
							return true
						end
					end
				end,
			},
			["markdownlint-cli2"] = {
				condition = function(_, ctx)
					local diag = vim.tbl_filter(function(d)
						return d.source == "markdownlint"
					end, vim.diagnostic.get(ctx.buf))
					return #diag > 0
				end,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			svelte = { "prettier" },
			go = { "goimports", "gofumpt" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			["javascript.jsx"] = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			["typescript.tsx"] = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
			["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
			yaml = { "prettier" },
			dockerfile = { "hadolint" },
			ruby = { "rubocop" },
			erbudy = { "erb_format" },
		},
	},
}
