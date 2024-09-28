local Servers = require("servers")

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    local ensure_installed = vim.tbl_keys(Servers.lsp or {})
    for _, y in pairs(Servers.formatter) do
      vim.list_extend(ensure_installed, y)
    end

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
      integrations = {
        ["mason-lspconfig"] = true,
      },
    })
  end,
}
