return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "b0o/SchemaStore.nvim",
  },
  config = function()
    local servers = require("config.mason").lsp

    local capabilities = vim.lsp.protocol.make_client_capabilities()

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

      vim.tbl_extend("force", { capabilities = capabilities }, config)

      vim.lsp.config(server, config)
    end
    local diagnostic_signs = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    }

    local shorter_source_names = {
      ["Lua Diagnostics."] = "Lua",
      ["Lua Syntax Check."] = "Lua",
    }

    local function diagnostic_format(diagnostic)
      return string.format(
        "%s %s (%s): %s",
        diagnostic_signs[diagnostic.severity],
        shorter_source_names[diagnostic.source] or diagnostic.source,
        diagnostic.code,
        diagnostic.message
      )
    end

    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        prefix = "",
        format = diagnostic_format,
      },
      signs = {
        text = diagnostic_signs,
      },
      virtual_lines = {
        current_line = true,
        format = diagnostic_format,
      },
      underline = true,
      severity_sort = true,
    })
  end,
}
