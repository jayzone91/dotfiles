local source_mapping = {
  nvim_lsp = "[LSP]",
  luasnip = "[SNIP]",
  buffer = "[BUF]",
  path = "[PATH]",
}

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",

      -- Snippets
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Icons
      "onsails/lspkind.nvim",
      "js-everts/cmp-tailwind-colors",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local cmp_tailwind = require("cmp-tailwind-colors")

      cmp.setup({
        ---@diagnostic disable-next-line:missing-fields
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            ellipsis_char = "...",
            before = function(entry, item)
              cmp_tailwind.format(entry, item)
              return item
            end,
            menu = source_mapping,
          }),
        },
        preselect = cmp.PreselectMode.Item,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        ---@diagnostic disable-next-line:missing-fields
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
