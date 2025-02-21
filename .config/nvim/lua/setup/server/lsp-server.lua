return {
  tailwindcss = {},
  cssls = {
    settings = {
      css = {
        lint = {
          emptyRules = "ignore",
          duplicateProperties = "warning",
        },
      },
      scss = {
        lint = {
          idSelector = "warning",
          zeroUnits = "warning",
          duplicateProperties = "warning",
          emptyRules = nil,
        },
        completion = {
          completePropertyWithSemicolon = true,
          triggerPropertyValueCompletion = true,
        },
      },
    },
  },
  ts_ls = {},
  html = {},
  stylelint_lsp = {
    filetypes = { "css", "scss" },
    root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
    settings = {
      stylelintplus = {},
    },
  },
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
