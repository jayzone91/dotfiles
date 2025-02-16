return {
  lua = { "stylua" },
  python = { "isort", "black" },
  javascript = { "prettierd", "prettier" },
  javascriptreact = { "prettierd", "prettier" },
  typescript = { "prettierd", "prettier" },
  typescriptreact = { "prettierd", "prettier" },
  json = { "prettierd", "prettier" },
  markdown = { "prettierd", "prettier", "markdownlint-cli2", "markdown-toc" },
  ["markdown.mdx"] = {
    "prettierd",
    "prettier",
    "markdownlint-cli2",
    "markdown-toc",
  },
  html = { "prettierd", "prettier" },
  toml = { "taplo" },
  css = { "prettierd", "prettier" },
  scss = { "prettierd", "prettier" },
  go = { "goimports", "gofumpt" },
}
