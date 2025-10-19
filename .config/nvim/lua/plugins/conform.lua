return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = function()
    local f = require("config.lsp").formatter
    f.javascript = { "biome", "biome-organize-imports" }
    f.javascriptreact = { "biome", "biome-organize-imports" }
    f.javascript.jsx = { "biome", "biome-organize-imports" }
    f.typescript = { "biome", "biome-organize-imports" }
    f.typescriptreact = { "biome", "biome-organize-imports" }
    f.typescript.tsx = { "biome", "biome-organize-imports" }
    return {
      formatters_by_ft = f,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in
              ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false))
            do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
    }
  end,
}
