return {
  "neovim/nvim-lspconfig",
  event = {"BufEnter", "BufNewFile"},
  dependencies = {
    {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  },
  opts = {
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        }
      }
    }
  },
  config = function(_, opts)
    local lsp_server = require("config.lsp")
    local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
    local has_blink, blink = pcall(require, "blink.cmp")

    local capabilities = vim.tbl_deep_extend(
      "force", 
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp.default_capabilities() or {},
      has_blink and blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    for server, config in pairs(lsp_server) do
      if type(config) ~= "table" then
        config = {}
      end
      config.capabilities = capabilities
      vim.lsp.enable(server)
      vim.lsp.config(server,config)
    end
  end,
}
