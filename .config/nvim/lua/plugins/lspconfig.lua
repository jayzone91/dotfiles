return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      vim.api.nvim_create_autocmd(
        { "BufWritePre" },
        { pattern = { "*.templ" }, callback = vim.lsp.buf.format }
      )

      local on_attach = function(_client, _bufnr)
        -- other configuration options
      end

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
              disable = { "different_requires" },
            },
          },
        },
      })

      lspconfig.gopls.setup({
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
          env = {
            GOEXPERIMENT = "rangefunc",
          },
          formatting = {
            gofumpt = true,
          },
        },
      })

      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        settings = {
          tailwindCSS = {
            includeLanguages = {
              templ = "html",
            },
          },
        },
      })

      lspconfig.ts_ls.setup({})

      lspconfig.html.setup({
        capabilites = capabilites,
        filetypes = { "html", "templ" },
      })

      lspconfig.htmx.setup({
        capabilites = capabilites,
        filetypes = { "html", "templ" },
      })
    end,
  },
}
