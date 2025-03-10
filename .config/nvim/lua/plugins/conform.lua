return {
  "stevearc/conform.nvim",
  event = { "BufEnter", "BufNew" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofumpt" },
      temp = { "gofumpt", "templ" },
      markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
