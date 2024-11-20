return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    -- Package Manager
    "williamboman/mason.nvim",
    -- LSP Extension to mason
    "williamboman/mason-lspconfig.nvim",
    -- Install and Upgrade third party tools automatically
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- UI for LSP Progress
    { "j-hui/fidget.nvim", opts = {} },
    -- Blink.cmp Completion
    "saghen/blink.cmp",
    -- Faster LuaLS setup for Neovim
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "luvit-meta/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
      dependencies = {
        { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
      },
    },
  },
  config = function()
    -- Setup Mason
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Setup Mason LSPconfig
    require("mason-lspconfig").setup({
      -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
      -- This setting has no relation with the `automatic_installation` setting.
      ---@type string[]
      ensure_installed = {
        "bashls",
        "stimulus_ls",
        "clangd",
        "cssls",
        "dockerls",
        "docker_compose_language_service",
        "emmet_ls",
        "gopls",
        "templ",
        "tailwindcss",
        "html",
        "vtsls",
        "jsonls",
        "lua_ls",
        "marksman",
        "intelephense",
        "prismals",
        "pyright",
        "rust_analyzer",
        "taplo",
        "yamlls",
      },

      -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Servers are not automatically installed.
      --   - true: All servers set up via lspconfig are automatically installed.
      --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
      ---@type boolean
      automatic_installation = true,

      -- See `:h mason-lspconfig.setup_handlers()`
      ---@type table<string, fun(server_name: string)>?
      handlers = {
        function(server_name) -- default handler
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          require("lspconfig")[server_name].setup({
            capabilities = require("blink.cmp").get_lsp_capabilities(
              capabilities
            ),
          })
        end,
        -- Next, you can provide targeted overrides for specific servers.
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enabled = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          })
        end,
        ["vtsls"] = function()
          require("lspconfig").vtsls.setup({
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
                  completion = {
                    enableServerSideFuzzyMatch = true,
                  },
                },
              },
              typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                  completeFunctionCall = true,
                },
                inlayHints = {
                  enumMemberValues = { enabled = true },
                  functionLikeReturnType = { enabled = true },
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  variableTypes = { enabled = false },
                },
              },
            },
          })
        end,
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local cient = assert(vim.lsp.get_client_by_id(args.data.client_id), "")

        local builtin = require("telescope.builtin")

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

        vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set(
          "n",
          "<space>ca",
          vim.lsp.buf.code_action,
          { buffer = 0 }
        )
        vim.keymap.set(
          "n",
          "<space>wd",
          builtin.lsp_document_symbols,
          { buffer = 0 }
        )
      end,
    })
  end,
}
