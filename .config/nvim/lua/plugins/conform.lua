local formatter = require("config.software").formatter

return {
	"stevearc/conform.nvim",
	event = require("config.utils").lazyFile,
	opts = {
		formatters_by_ft = formatter,
		format_on_save = {
			timeout_ms = 2500,
			lsp_format = "fallback",
		},
	},
}
