return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = function()
		return {
			animate = { enabled = false },
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			indent = {
				enabled = true,
				char = "▎",
				animate = { enabled = false },
				indent = {
					only_current = true,
					only_scope = true,
				},
				scope = {
					enabled = true,
					only_current = true,
					only_scope = true,
					underline = false,
				},
				chunk = {
					enabled = true,
					only_current = true,
				},
				filter = function(buf)
					return vim.g.snacks_indent ~= false
						and vim.b[buf].snacks_indent ~= false
						and vim.bo[buf].buftype == ""
						and vim.bo[buf].filetype ~= "markdown"
				end,
			},
			input = { enabled = true },
			notifier = {
				enabled = true,
				win = {
					backdrop = {
						transparent = false,
					},
				},
			},
			quickfile = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = true },
			words = { enabled = false },
			toggle = {
				which_key = true,
				notify = true,
				icon = {
					enabled = " ",
					disabled = " ",
				},
				color = {
					enabled = "green",
					disabled = "yellow",
				},
			},
			zen = {
				minimal = true,
				toggles = {
					dim = false,
				},
				win = {},
				show = {
					statusline = false,
					tabline = false,
				},
			},
			styles = {
				zen = {
					backdrop = {
						transparent = false,
					},
					width = 100,
					wo = {
						number = false,
						signcolumn = "no",
						cursorcolumn = false,
						relativenumber = false,
					},
				},
				notifications = {
					wo = {
						spell = false,
						winblend = 0,
					},
				},
			},
		}
	end,
}
