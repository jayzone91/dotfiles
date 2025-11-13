return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  lazy = false,
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  opts = function()
    local ensure_installed = {}
    local servers = require("config.mason")

    for x, _ in pairs(servers.lsp) do
      table.insert(ensure_installed, x)
    end

    for _, x in pairs(servers.linter) do
      vim.list_extend(ensure_installed, x)
    end

    for _, x in pairs(servers.formatter) do
      vim.list_extend(ensure_installed, x)
    end

    return {
      ensure_installed = ensure_installed,
      auto_update = true,
    }
  end,
  config = function(_, opts)
    require("mason-tool-installer").setup(opts)
  end,
}
