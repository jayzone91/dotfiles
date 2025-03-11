return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = require("config.mason").lsp,
        automatic_installation = true,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = require("config.mason").other,
        auto_update = true,
      })
    end,
    dependencies = { "williamboman/mason.nvim" },
    lazy = false,
  },
}
