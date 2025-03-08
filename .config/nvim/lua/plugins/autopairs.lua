return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })

      local ts_conds = require("nvim-autopairs.ts-conds")

      npairs.add_rules({
        Rule("%", "%", "lua"):with_pair(
          ts_conds.is_ts_node({ "string", "comment" })
        ),
        Rule("$", "$", "lua"):with_pair(
          ts_conds.is_not_ts_node({ "function" })
        ),
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup({
        aliases = {
          ["templ"] = "html",
        },
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = true,
          virtual_text = {
            spacing = 5,
            severity_limit = "Warning",
          },
          update_in_insert = true,
        })
    end,
  },
}
