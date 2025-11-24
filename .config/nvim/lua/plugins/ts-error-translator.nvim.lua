return {
  "dmmulroy/ts-error-translator.nvim",
  ft = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
  opts = {
    auto_attach = true,
    servers = {
      "ts_ls",
      "astro",
      "svelte",
      "tsserver",
      "typescript-tools",
      "volar",
      "vtsls",
    },
  },
}
