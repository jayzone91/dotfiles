local ok, mason = pcall(require, "mason")
if not ok then
  return
end

mason.setup()

local ok_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if not ok_lsp then
  return
end

mason_lsp.setup()

local ok_tool, mason_tool = pcall(require, "mason-tool-installer")
if not ok_tool then
  return
end

mason_tool.setup({
  ensure_installed = {
    -- LSP
    "lua_ls",

    -- Formatter
    "stylua",
  },
  auto_update = true,
})

local ok_fidget, fidget = pcall(require, "fidget")
if ok_fidget then
  fidget.setup({})
end

local ok_conform, conform = pcall(require, "conform")
if ok_conform then
  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  })
end

local capabilities = {}
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities()
end

local lsp_lines_ok, lsp_lines = pcall(require, "lsp_lines")
if lsp_lines_ok then
  lsp_lines.setup()
  vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false,
  })
end

-- LSP Config
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        verion = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})
