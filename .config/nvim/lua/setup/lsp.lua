local capabilities = require("blink.cmp").get_lsp_capabilities()
local lsp_table = require("setup.server.lsp-server")

local lsp = {}
for key, _ in pairs(lsp_table) do
  table.insert(lsp, key)
end

require("mason-lspconfig").setup({
  ensure_installed = lsp,
  automatic_installation = true,
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local lspconfig = require("lspconfig")

-- LSP Server Config

for server, config in pairs(lsp_table) do
  if config == true then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {}, {
    capabilites = capabilities,
    on_attach = function(client)
      client.server_capabilities.document_formatting = false
    end,
  }, config)

  lspconfig[server].setup(config)
end

-- LSP Prevents inline buffer annotations
vim.diagnostic.open_float()
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
    update_on_insert = false,
  })

local signs = {
  Error = "󰅚 ",
  Warn = "󰳦 ",
  Hint = "󱡄 ",
  Info = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
end
