return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		animate = { enabled = false },
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = {
			enabled = true,
			example = "compact_files",
		},
		debug = { enabled = false },
		dim = { enabled = false },
		explorer = { enabled = true },
		git = { enabled = true },
		gitbrowse = { enabled = false },
		image = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		layout = { enabled = false },
		lazygit = { enabled = false },
		notifier = { enabled = true, timeout = 3000 },
		notify = { enabled = true },
		picker = { enabled = true },
		profiler = { enabled = false },
		quickfile = { enabled = true },
		rename = { enabled = true },
		scope = { enabled = true },
		scratch = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		terminal = { enabled = true },
		toggle = { enabled = true },
		util = { enabled = false },
		win = { enabled = false },
		words = { enabled = true },
		zen = { enabled = false },
		styles = {
			notification = {
				wo = { wrap = true },
			},
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader><space>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
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
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},

		-- LSP
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
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>tt",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd

				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tr")
			end,
		})

		---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
		local progress = vim.defaulttable()
		vim.api.nvim_create_autocmd("LspProgress", {
			---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
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
	end,
}
