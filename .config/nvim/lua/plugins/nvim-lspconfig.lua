local lsp_server = require("installs.lsp")

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
          { path = "nvim-lspconfig", words = { "lspconfig.settings" } },
        },
      },
    },
    {
      "mason-org/mason.nvim",
    },
    { "mason-org/mason-lspconfig.nvim", opts = {} },
  },
  config = function()
    -- Get Capabilites
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if pcall(require, "cmp_nvim_lsp") then
      vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
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

    -- Inlay hints
    -- Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
    --   if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
    --     vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
    --   end
    -- end)
    --
    -- -- code lens
    -- if vim.lsp.codelens then
    --   Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function()
    --     vim.lsp.codelens.enable(true)
    --   end)
    -- end
  end,
}
