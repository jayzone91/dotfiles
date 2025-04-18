local M = {}

M.lsp = {
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = { checkThirdParty = false },
			},
		},
	},
}

M.formatter = {
	lua = { "stylua" },
}

return M
