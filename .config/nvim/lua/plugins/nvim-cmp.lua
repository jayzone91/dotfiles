return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- CMP Plugins
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    -- Snippets
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    -- Tailwind
    { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
  },
  opts = {
    formatting = {
      format = function(_, item)
        local icons = {
          Array = " ",
          Boolean = "󰨙 ",
          Class = " ",
          Codeium = "󰘦 ",
          Color = " ",
          Control = " ",
          Collapsed = " ",
          Constant = "󰏿 ",
          Constructor = " ",
          Copilot = " ",
          Enum = " ",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = " ",
          Folder = " ",
          Function = "󰊕 ",
          Interface = " ",
          Key = " ",
          Keyword = " ",
          Method = "󰊕 ",
          Module = " ",
          Namespace = "󰦮 ",
          Null = " ",
          Number = "󰎠 ",
          Object = " ",
          Operator = " ",
          Package = " ",
          Property = " ",
          Reference = " ",
          Snippet = "󱄽 ",
          String = " ",
          Struct = "󰆼 ",
          Supermaven = " ",
          TabNine = "󰏚 ",
          Text = " ",
          TypeParameter = " ",
          Unit = " ",
          Value = " ",
          Variable = "󰀫 ",
        }
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        local widths = {
          abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
          menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
        }

        for key, width in pairs(widths) do
          if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
            item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
          end
        end

        return item
      end,
    },
  },
  config = function(_, opts)
    local cmp = require("cmp")

    cmp.setup({
      formatting = {
        format = function(entry, vim_item)
          local format_kinds = opts.formatting.format
          format_kinds(entry, vim_item) -- add icons
          return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
        end,
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        dpcumentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}
