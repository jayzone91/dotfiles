return {
  "hrsh7th/cmp-nvim-lsp",
  event = "InsertEnter",
  dependencies = {
    -- Sources
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "SergioRibera/cmp-dotenv",

    -- Snippets
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",

    -- Better Sorting
    "lukas-reineke/cmp-under-comparator",

    -- Icons
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = {
            menu = 50,
            abbr = 50,
          },
          ellipsis_char = "...",
          show_labelDetails = true,
          before = function(_, vim_item)
            return vim_item
          end,
        }),
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
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      ---@diagnostic disable-next-line:missing-fields
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          require("cmp-under-comparator").under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      sources = cmp.config.sources({
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "dotenv" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      ---@diagnostic disable-next-line:missing-fields
      matching = {
        disallow_symbol_nonprefix_matching = false,
      },
    })
  end,
}
