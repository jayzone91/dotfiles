local lsp_server = require("config.plugins.mason").lsp_server

local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  has_cmp and cmp_nvim_lsp.default_capabilities() or {},
  {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  }
)

local lspconfig = require("lspconfig")

local diag = vim.lsp.diagnostic
diag.underline = true
diag.update_in_insert = false
diag.virtual_text = {
  spacing = 4,
  source = "if_many",
  prefix = "●",
}
diag.severity_sort = true
vim.lsp.codelens = { enabled = true }
vim.lsp.document_highlight = true

for name, config in pairs(lsp_server) do
  config = vim.tbl_deep_extend("force", {}, {
    capabilities = capabilities,
  }, config)

  lspconfig[name].setup(config)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(
      vim.lsp.get_client_by_id(args.data.client_id),
      "must have valid client"
    )

    local settings = lsp_server[client.name]
    if type(settings) ~= "table" then
      settings = {}
    end

    local builtin = require("telescope.builtin")

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
    vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "cr", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { buffer = 0 })

    -- Override server capabilities
    if settings.server_capabilities then
      for k, v in pairs(settings.server_capabilities) do
        if v == vim.NIL then
          ---@diagnostic disable-next-line: cast-local-type
          v = nil
        end
        client.server_capabilities[k] = v
      end
    end
  end,
})
