return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  lazy = false,
  config = function()
    print("Start")
    require("mason").setup({
      ui = {
        border = "rounded",
      },
    })

    local lsp_table = require("config.lsp")
    local lsp = {}
    for key, _ in pairs(lsp_table) do
      table.insert(lsp, key)
    end

    require("mason-lspconfig").setup({
      ensure_installed = lsp,
      automatic_installation = true,
    })

    local to_install = {}
    for _, value in pairs(require("config.formatter")) do
      for i = 1, #value, 1 do
        table.insert(to_install, value[i])
      end
    end

    for _, value in pairs(require("config.linter")) do
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
