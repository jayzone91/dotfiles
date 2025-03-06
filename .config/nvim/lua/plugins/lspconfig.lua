return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local lsp = require("plugins.configs.lsp")

      for server, config in pairs(lsp) do
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
          on_attach = function(client)
            client.server_capabilities.document_formatting = false
          end,
        }, config)

        lspconfig[server].setup(config)
      end

      lspconfig.templ.setup({})
    end,
  },
}
