-- Mason Utils to install
-- LSP Server Config
-- Formatters
-- Linters

local M = {}

M.LSP = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = {version = "LuaJIT"},
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  }
}

M.Formatter = {}

M.Linter = {}

return M
