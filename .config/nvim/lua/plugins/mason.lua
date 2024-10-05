return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  build = ":MasonUpdate",
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        width = 0.8,
        height = 0.8,
      },
    })

    local servers = require("servers")
    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers.lsp[key]
      if type(t) == "table" then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers.lsp))

    local ensure_installed = {
      "js-debug-adapter",
      "phpcs",
      "php-cs-fixer",
    }
    vim.list_extend(ensure_installed, servers_to_install)
    for _, formatter in pairs(servers.formatters) do
      vim.list_extend(ensure_installed, formatter)
    end

    for _, formatter in pairs(servers.linter) do
      vim.list_extend(ensure_installed, formatter)
    end
    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      run_on_start = true,
      auto_update = true,
      debounde_hours = 0,
    })
  end,
}
