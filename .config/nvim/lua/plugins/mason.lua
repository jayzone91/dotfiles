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

    local formatters_to_install = {}
    for _, value in pairs(Server.formatter) do
      for i = 1, #value, 1 do
        table.insert(formatters_to_install, value[i])
      end
    end

    require("mason-tool-installer").setup({
      ensure_installed = formatters_to_install,
      auto_update = true,
    })
  end,
}
