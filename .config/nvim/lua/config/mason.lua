local M = {}

M.mason = function()
  return {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      border = "double",
    },
  }
end

M.mason_lspconfig = function()
  local lsp_server = {}
  if pcall(require, "config.lsp") then
    lsp_server = require("config.lsp").server
  end

  local ensure_installed = {}
  for server, _ in pairs(lsp_server) do
    table.insert(ensure_installed, server)
  end

  -- make capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }

  local on_init = function(client, _)
    if vim.fn.has("nvim-0.11") ~= 1 then
      if client.supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
      end
    else
      if client:supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end
  end

  if pcall(require, "cmp_nvim_lsp") then
    vim.tbl_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )
  end

  if pcall(require, "blink.cmp") then
    vim.tbl_extend(
      "force",
      capabilities,
      require("blink.cmp").get_lsp_capabilities()
    )
  end

  -- set Config for servers
  for server, config in pairs(lsp_server) do
    config = config or {}
    vim.tbl_extend(
      "force",
      { capabilities = capabilities, on_init = on_init },
      config
    )
    vim.lsp.config(server, config)
  end

  return {
    ensure_installed = ensure_installed,
    auto_update = true,
  }
end

M.mason_tool_installer = function()
  local ok, mason = pcall(require, "mason-tool-installer")
  if not ok then
    return
  end

  local formatter = {}
  if pcall(require, "config.conform") then
    formatter = require("config.conform").formatter
  end
  local linter = {}
  if pcall(require, "config.lint") then
    linter = require("config.lint").linter
  end

  local ensure_installed = {}

  for _, x in pairs(formatter) do
    vim.list_extend(ensure_installed, x)
  end
  for _, x in pairs(linter) do
    vim.list_extend(ensure_installed, x)
  end

  mason.setup({
    ensure_installed = ensure_installed,
    auto_update = true,
  })
end

return M
