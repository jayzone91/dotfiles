return {
  "stevearc/conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local formatters_by_ft = require("servers").formatters
    local formatters = {
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
    }
    vim.list_extend(formatters, formatters_by_ft)

    require("conform").setup({
      formatters_by_ft = formatters,
      formatters = {
        ["markdown-tox"] = {
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
        ["markdown-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
        })
      end,
    })
  end,
}
