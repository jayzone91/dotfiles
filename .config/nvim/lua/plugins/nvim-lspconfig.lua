return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "b0o/SchemaStore.nvim",
  },
  config = function()
    local servers = require("config.mason").lsp

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local on_attach = function()
      vim.keymap.set("n", "H", function()
        vim.lsp.buf.hover()
      end)
    end

    if pcall(require, "cmp_nvim_lsp") then
      vim.tbl_extend(
        "force",
        capabilities,
        require("cmp_nvim_lsp").default_capabilites()
      )
    end

    if pcall(require, "blink.cmp") then
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        require("blink.cmp").get_lsp_capabilities({}, false)
      )
    end

    for server, config in pairs(servers) do
      vim.lsp.enable(server)
      config = config or {}

      vim.tbl_extend(
        "force",
        { capabilities = capabilities, on_attach = on_attach },
        config
      )

      vim.lsp.config(server, config)
    end
  end,
}
