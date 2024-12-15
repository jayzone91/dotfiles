---@param opts? {select: boolean, behaviour: cmp.ConfirmBehavior}
local function confirm(opts)
  local cmp = require("cmp")
  opts = vim.tbl_extend("force", {
    select = true,
    behaviour = cmp.ConfirmBehavior.Insert,
  }, opts or {})

  return function(fallback)
    if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
      if cmp.confirm(opts) then
        return
      end
    end
    return fallback()
  end
end

return {
  "hrsh7th/nvim-cmp",
  version = false,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "SergioRibera/cmp-dotenv",
    "onsails/lspkind-nvim",
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      event = "InsertEnter",
      postinstall = "make istall_jsregexp",
      config = function()
        local luasnip = require("luasnip")
        luasnip.config.setup({
          history = true,
          updateevents = "TextChanged,TextChangedI",
          enable_autosnippets = true,
        })
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local lsp_kind = require("lspkind")
    local luasnip = require("luasnip")

    require("tailwindcss-colorizer-cmp").setup({
      color_square_width = 2,
    })

    lsp_kind.init()

    cmp.setup({
      sorting = defaults.sorting,
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      preselect = cmp.PreselectMode.item,
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PMenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PMenuSel,Search:None",
        }),
      },
      view = {
        entries = "bordered",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<c-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = confirm({ select = true }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip", max_item_count = 5 },
        { name = "nvim_lsp", max_item_count = 20 },
        { name = "nvim_lua" },
        { name = "path" },
        {
          name = "buffer",
          max_item_count = 2,
        },
        {
          name = "dotenv",
          option = {
            load_shell = false,
          },
        },
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

    -- Tailwind colorizer
    require("cmp").config.formatting = {
      fields = { "menu", "abbr", "kind" },
      format = function(entry, item)
        local entryItem = entry:get_completion_item()
        local color = entryItem.documentation

        if
          color
          and type(color) == "string"
          and color:match("^#%x%x%x%x%x%x$")
        then
          local hl = "hex-" .. color:sub(2)

          if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then
            vim.api.nvim_set_hl(0, hl, { fg = color })
          end

          item.menu = " "
          item.menu_hl_group = hl
        end
        return item
      end,
    }
  end,
}
