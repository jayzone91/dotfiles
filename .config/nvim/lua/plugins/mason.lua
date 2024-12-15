local Server = require("config.server")

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
      },
    })
    require("mason-lspconfig").setup({
      ensure_installed = Server.lsp,
      automatic_installation = true,
    })

    local to_install = {}
    for _, value in pairs(Server.formatter) do
      for i = 1, #value, 1 do
        table.insert(to_install, value[i])
      end
    end

    for _, value in pairs(Server.linter) do
      for i = 1, #value, 1 do
        table.insert(to_install, value[i])
      end
    end

    require("mason-tool-installer").setup({
      ensure_installed = to_install,
      auto_update = true,
    })
  end,
}
