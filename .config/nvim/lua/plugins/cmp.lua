return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  version = false, -- last release is way too old
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    -- Better Sorting
    "lukas-reineke/cmp-under-comparator",
    -- Tailwind CSS Colors
    {
      "roobert/tailwindcss-colorizer-cmp.nvim",
      config = function()
        require("tailwindcss-colorizer-cmp").setup({
          color_square_width = 2,
        })
      end,
    },
    "onsails/lspkind.nvim",
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.opt.shortmess:append("c")

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
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
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "vsnip" },
      }, {
        { name = "buffer" },
      }),
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
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxWidth = 120,
          menu = {
            nvim_lsp = "[LSP]",
            path = "[Path]",
            buffer = "[Buffer]",
            luasnip = "[LuaSnip]",
          },
          before = function(entry, vim_item)
            if
              vim_item.kind == "Color" and entry.completion_item.documentation
            then
              return require("tailwindcss-colorizer-cmp").formatter(
                entry,
                vim_item
              )
            end
            vim_item.kind = lspkind.symbolic(vim_item.kind)
                and lspkind.symbolic(vim_item.kind)
              or vim_item.kind
            return vim_item
          end,
        }),
      },
      experimental = {
        ghost_text = true,
      },
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
      matching = { disallow_symbol_nonprefix_matching = false },
    })

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "'if_many'" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      },
      virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    })
  end,
}
