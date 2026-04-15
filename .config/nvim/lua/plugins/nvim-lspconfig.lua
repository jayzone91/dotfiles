return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
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
    {
      "mason-org/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
    { "mason-org/mason-lspconfig.nvim", opts = {} },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = function()
        -- install tools
        local ensure_installed = {}

        local lsp_server = require("installs/lsp")
        local linter = require("installs/linter")
        local formatter = require("installs/formatter")

        for x, _ in pairs(lsp_server) do
          table.insert(ensure_installed, x)
        end

        for _, x in pairs(linter) do
          vim.list_extend(ensure_installed, x)
        end

        for _, x in pairs(formatter) do
          vim.list_extend(ensure_installed, x)
        end

        return {
          ensure_installed = ensure_installed,
          auto_update = true,
        }
      end,
    },
  },
  config = function()
    local lsp_server = require("installs/lsp")

    -- Get Capabilites
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if pcall(require, "cmp_nvim_lsp") then
      vim.tbl_extend("force", capabilites, require("cmp_nvim_lsp").default_capabilities())
    end

    if pcall(require, "blink.cmp") then
      vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
    end

    -- Set Hover
    local on_attach = function()
      vim.keymap.set("n", "H", function()
        vim.lsp.buf.hover()
      end)
    end
    --
    -- Config LSP Servers
    for server, config in pairs(lsp_server) do
      config = config or {}

      vim.tbl_extend("force", { capabilities = capabilities, on_attach = on_attach }, config)

      vim.lsp.config(server, config)
    end
  end,
}
