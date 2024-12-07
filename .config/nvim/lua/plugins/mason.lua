local Server = require("server")

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = Server.lsp,
      automatic_installation = true,
    })
    require("mason-tool-installer").setup({
      ensure_installed = Server.formatter,
      auto_update = true,
    })
  end,
}
