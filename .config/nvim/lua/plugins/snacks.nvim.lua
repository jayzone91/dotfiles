return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	dependencies = { "nvim-mini/mini.icons", opts = {} },
	---@type snacks.Config
	opts = {
		animate = { enabled = false },
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = { enabled = false },
		debug = { enabled = false },
		dim = { enabled = false },
		explorer = { enabled = true, replace_netrw = true, trash = false },
		gh = { enabled = false },
		git = { enabled = true },
		gitbrowse = { enabled = false },
		image = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		keymap = { enabled = true },
		layout = { enabled = false },
		lazygit = { enabled = false },
		notifier = { enabled = true, timeout = 3000 },
		notify = { enabled = true },
		picker = { enabled = true },
		profiler = { enabled = false },
		quickfile = { enabled = true },
		rename = { enabled = true },
		scope = { enabled = true },
		scratch = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		terminal = { enabled = false },
		toggle = { enabled = true },
		util = { enabled = true },
		win = { enabled = false },
		words = { enabled = false },
		zen = { enabled = false },
		styles = { notification = { wo = { wrap = true } } },
	},
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer({
					auto_close = true,
				})
			end,
			desc = "File Explorer",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"gai",
			function()
				Snacks.picker.lsp_incoming_calls()
			end,
			desc = "C[a]lls Incoming",
		},
		{
			"gao",
			function()
				Snacks.picker.lsp_outgoing_calls()
			end,
			desc = "C[a]lls Outgoing",
		},
	},
}
