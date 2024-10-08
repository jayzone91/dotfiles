return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Autoinstall Lsp Servers
    "williamboman/mason.nvim",

    { "j-hui/fidget.nvim", opts = {} },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    require("config.plugins.lsp")
  end,
}
