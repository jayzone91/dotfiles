local options = {
  formatters_by_ft = {
    php = { "php_cs_fixer" },
    lua = { "stylua" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    ["javascript.jsx"] = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    ["typescript.tsx"] = { "biome" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
    ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
    yaml = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = "fallback",
  },
}

return options
