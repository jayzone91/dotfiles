return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
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
			markdown = { "prettier" },
			yaml = { "prettier" },
		},
	},
}
