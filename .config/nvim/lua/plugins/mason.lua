return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    { "neovim/nvim-lspconfig" },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
      "b0o/SchemaStore.nvim",
      lazy = true,
      version = false, -- last release is way too old
    },
    {
      "SmiteshP/nvim-navic",
      lazy = true,
      opts = function()
        return {
          separator = " ",
          highlight = true,
          depth_limit = 5,
          lazy_update_context = true,
        }
      end,
    },
  },
  config = function()
    require("config.lsp").mason()
  end,
}
