return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    { "saghen/blink.compat", opts = { impersonate_nvim_cmp = true } },
    "Exafunction/codeium.nvim",
    { "echasnovski/mini.icons", version = false },
  },
  build = "cargo build --release",
  event = { "InsertEnter" },
  opts = {
    keymap = { preset = "enter" },
    sources = {
      compat = { "codeium" },
      default = {
        "lazydev",
        "lsp",
        "path",
        "snippets",
        "buffer",
      },
      providers = {
        codeium = {
          name = "codeium",
          module = "blink.compat.source",
          score_offset = 100,
          async = true,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      menu = {
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ =
                  require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    opts.sources.compat = nil

    for _, provider in pairs(opts.sources.providers or {}) do
      if provider.kind then
        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
        local kind_idx = #CompletionItemKind + 1
        CompletionItemKind[kind_idx] = provider.kind
        CompletionItemKind[provider.kind] = kind_idx

        local transform_items = provider.transform_items
        provider.transform_items = function(ctx, items)
          items = transform_items and transform_items(ctx, items) or items
          for _, item in ipairs(items) do
            item.kind = kind_idx or item.kind
          end
          return items
        end
        provider.kind = nil
      end
    end
    require("blink.cmp").setup(opts)
  end,
}
