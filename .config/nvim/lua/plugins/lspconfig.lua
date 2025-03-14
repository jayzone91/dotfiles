return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
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
    {
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      opts = {
        bind = true,
        handler_opts = {
          border = "rounded",
        },
      },
    },
  },
  config = function()
    local Server = require("config.mason").LSP
    local has_blink, blink = pcall(require, "blink.cmp")
    local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend("force", {}, {
      vim.lsp.protocol.make_client_capabilities(),
      has_blink and blink.get_lsp_capabilities() or {},
      has_cmp and cmp.default_capabilities() or {},
    })

    for lsp, config in pairs(Server) do
      if type(config) ~= "table" then
        config = {}
      end
      vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, config)
      require("lspconfig")[lsp].setup(config)
    end

    -- Set Keymaps for LSP on attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(_)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
      end,
    })
  end,
}
