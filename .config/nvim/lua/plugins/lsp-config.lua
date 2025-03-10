return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
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
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    vim.filetype.add({ extension = { templ = "templ" } })

    lspconfig.cssls.setup({ capabilities = capabilities })
    lspconfig.dockerls.setup({ capabilities = capabilities })
    lspconfig.marksman.setup({ capabilities = capabilities })
    lspconfig.templ.setup({ capabilities = capabilities })
    lspconfig.html.setup({ capabilities = capabilities })
    lspconfig.prismals.setup({ capabilities = capabilities })
    lspconfig.gopls.setup({ capabilities = capabilities })
    lspconfig.htmx.setup({ capabilities = capabilities })
    lspconfig.jsonls.setup({ capabilities = capabilities })
    lspconfig.intelephense.setup({ capabilities = capabilities })
    lspconfig.powershell_es.setup({ capabilities = capabilities })
    lspconfig.pyright.setup({ capabilities = capabilities })
    lspconfig.rust_analyzer.setup({ capabilities = capabilities })
    lspconfig.taplo.setup({ capabilities = capabilities })
    lspconfig.templ.setup({
      capabilities = capabilities,
      filetypes = { "html", "templ" },
    })
    lspconfig.yamlls.setup({ capabilities = capabilities })
    lspconfig.tailwindcss.setup({
      filetypes = { "html", "templ", "javascriptreact", "typescriptreact" },
      capabilities = capabilities,
      on_attach = function(_, bufnr)
        require("tailwindcss-colors").buf_attach(bufnr)
      end,
    })
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = { checkThirdParty = false },
        },
      },
    })
    lspconfig.vtsls.setup({
      capabilities = capabilities,
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      settings = {
        complete_function_calls = true,
        vtsls = {
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            maxInlayHintLength = 30,
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
        },
      },
    })

    -- Create Keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(_)
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set(
          "n",
          "<leader>cr",
          vim.lsp.buf.rename,
          { buffer = 0, desc = "LSP Rename" }
        )
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = 0, desc = "LSP Code Actions" }
        )
      end,
    })
  end,
}
