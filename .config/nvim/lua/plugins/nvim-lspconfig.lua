local Servers = require("servers")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
      dependencies = {
        { "Bilal2453/luvit-meta", lazy = true },
      },
    },
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
  },
  opts = {},
  config = function(_, opts)
    local lspconfig = require("lspconfig")

    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      opts.capabilities or {}
    )

    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilites = vim.deepcopy(capabilities),
      }, Servers.lsp[server] or {})
      if server_opts.enabled == false then
        return
      end

      lspconfig[server].setup(server_opts)
    end

    local have_mason, mlsp = pcall(require, "mason-lspconfig")
    local all_mslp_servers = {}
    if have_mason then
      all_mslp_servers = vim.tbl_keys(
        require("mason-lspconfig.mappings.server").lspconfig_to_package
      )
    end

    local ensure_installed = {}
    for server, server_opts in pairs(Servers.lsp) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.enabled ~= false then
          if
            server_opts.mason == false
            or not vim.tbl_contains(all_mslp_servers, server)
          then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end
    end

    if have_mason then
      mlsp.setup({
        handlers = { setup },
      })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.onmifunc"
        local lsp_opts = function(desc)
          return { buffer = ev.buf, desc = desc }
        end
        vim.keymap.set(
          "n",
          "gD",
          vim.lsp.buf.declaration,
          lsp_opts("LSP: declaration")
        )
        vim.keymap.set("n", "gd", function()
          require("telescope.builtin").lsp_definitions({ reuse_win = true })
        end, lsp_opts("LSP: definition"))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, lsp_opts("LSP: Hover"))
        vim.keymap.set(
          "n",
          "gi",
          vim.lsp.buf.implementation,
          lsp_opts("LSP: implementation")
        )
        vim.keymap.set(
          "n",
          "gr",
          "<cmd>Telescope lsp_references<CR>",
          lsp_opts("References")
        )
        vim.keymap.set("n", "gI", function()
          require("telescope.builtin").lsp_implementations({ reuse_win = true })
        end, lsp_opts("Goto Implementations"))
        vim.keymap.set("n", "gy", function()
          require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end, lsp_opts("Goto Type Definition"))
        vim.keymap.set(
          "n",
          "<leader>rn",
          vim.lsp.buf.rename,
          lsp_opts("LSP: rename")
        )
        vim.keymap.set(
          { "n", "v" },
          "<leader>ca",
          vim.lsp.buf.code_action,
          lsp_opts("LSP: Code Actions")
        )
      end,
    })
  end,
}
