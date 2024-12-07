local M = {}

M.lsp = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdPary = false,
        },
      },
    },
  },
}

M.formatter = {
  lua = { "stylua" },
}

return M
