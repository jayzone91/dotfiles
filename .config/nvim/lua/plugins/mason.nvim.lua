return {
  "mason-org/mason-lspconfig.nvim",
  opts = require("config.mason").mason_lspconfig(),
  dependencies = {
    {
      "mason-org/mason.nvim",
      config = require("config.mason").mason(),
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = require("config.mason").mason_tool_installer(),
    },
    { "neovim/nvim-lspconfig", lazy = false },
    "b0o/schemastore.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv", "vim%.loop" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
  },
}
