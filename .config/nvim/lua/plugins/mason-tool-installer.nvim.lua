return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function()
    local server_list = require("config.lspserver").lsp
    local formatter_list = require("config.formatter").formatter
    local linter_list = require("config.linter").linter

    local ensure_installed = {}

    for x, _ in pairs(server_list) do
      table.insert(ensure_installed, x)
    end

    for _, x in pairs(formatter_list) do
      vim.list_extend(ensure_installed, x)
    end

    for _, x in pairs(linter_list) do
      vim.list_extend(ensure_installed, x)
    end

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
    })
  end,
}
