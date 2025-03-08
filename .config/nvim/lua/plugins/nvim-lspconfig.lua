return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
    "saghen/blink.cmp",
  },
  config = function()
    local lsp = require("config.lsp")

    local lspconfig = require("lspconfig")

    for server, config in pairs(lsp) do
      if config == true then
        config = {}
      end

      local blink = require("blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities()
      )
      capabilities = blink.get_lsp_capabilities(capabilities)

      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          if server == "tailwindcss" then
            require("tailwindcss-colors").buf_attach(bufnr)
          end
          client.server_capabilities.document_formatting = false
        end,
      }, config)

      lspconfig[server].setup(config)
    end
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(_)
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = 0 }
        )
      end,
    })
  end,
}
