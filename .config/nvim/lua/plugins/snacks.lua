-- Advanced LSP Progress
---@type table<number, {token:lsp.ProgressToken, msg: string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin"|"report"|"end"}]]
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]

		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end

		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)

		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		---@diagnostic disable-next-line
		vim.notify(table.concat(msg, "\n"), "info", {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})

local picker_config = {
	enabled = true,
	ui_select = true,
}

return {
	"folke/Snacks.nvim",
	dependencies = {
		{ "echasnovski/mini.icons", version = false },
		{ "nvim-tree/nvim-web-devicons", opts = {} },
	},
	priority = 1000,
	lazy = false,
	opts = {
		animate = { enabled = false },
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = { enabled = false },
		debug = { enabled = false },
		dim = { enabled = false },
		explorer = { enabled = true },
		git = { enabled = true },
		gitbrowse = { enabled = false },
		image = { enabled = false },
		indent = { enabled = true },
		inout = { enabled = true },
		layout = { enabled = false },
		lazygit = { enabled = false },
		notifier = { enabled = true },
		notify = { enabled = true },
		picker = picker_config,
		profiler = { enabled = false },
		quickfile = { enabled = true },
		rename = { enanbled = true },
		scope = { enabled = false },
		scratch = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		toggle = { enabled = false },
		win = { enabled = false },
		words = { enabled = true },
		zen = { enabled = false },
	},
	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer.open({
					hidden = true,
					ignored = true,
					auto_close = true,
				})
			end,
			desc = "Open Explorer",
		},
		{
			"<leader><space>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Search Buffers",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Search Files",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Search Keymaps",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Find Help",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live Grep",
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
				Snacks.picker.lsp_declaration()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementations",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto Type Definition",
		},
	},
}
