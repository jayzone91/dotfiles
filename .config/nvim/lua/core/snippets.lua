-- Prevent LSP from Overwriting treesitter color settings
vim.highlight.priorities.semantic_tokens = 95

-- Appearence of diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		-- Add custom format function to show error codes
		format = function(diagnostics)
			local code = diagnostics.code and string.format("[%s]", diagnostics.code) or ""
			return string.format("%s %s", code, diagnostics.message)
		end,
	},
	underline = false,
	update_in_insert = true,
	float = {
		source = "always",
	},
	-- Make diagnostics background transparent
	on_ready = function()
		vim.cmd("highlight DiagnosticVirtualText guibg=NONE")
	end,
})

-- Highlight on Yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
