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

local blink = require("blink.cmp")
local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  blink.get_lsp_capabilities()
)

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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(
      vim.lsp.get_client_by_id(args.data.client_id),
      "must have valid client id"
    )
    local settings = servers[client.name]
    if type(settings) ~= "table" then
      settings = {}
    end

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set("n", "gd", function()
      Snacks.picker.lsp_definitions()
    end, { desc = "GoTo Definition" })
    vim.keymap.set("n", "gr", function()
      Snacks.picker.lsp_references()
    end, { desc = "References" })
  end,
})
