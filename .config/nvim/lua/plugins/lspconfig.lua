return {

  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
    { "Bilal2453/luvit-meta", lazy = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = { checkThirdParty = false },
        },
      },
    })

    lspconfig.gopls.setup({
      capabilities = capabilities,
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

    lspconfig.htmx.setup({
      capabilities = capabilities,
      filetypes = { "html", "templ" },
    })

    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      settings = {
        includeLanguages = {
          templ = "html",
        },
      },
    })

    lspconfig.templ.setup({
      capabilities = capabilities,
    })
  end,
}
