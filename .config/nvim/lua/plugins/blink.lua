return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  build = "cargo build --release",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "saghen/blink.compat",
      opts = {},
      version = "*",
    },
  },
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "normal",
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = { draw = { treesitter = true } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    keymap = {
      preset = "enter",
    },
    sources = {
      compat = {},
      completion = {
        enable_providers = {
          "lsp",
          "path",
          "snippets",
          "buffers",
          "lazydev",
        },
      },
      providers = {
        lsp = { fallback_for = { "lazydev" } },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
        },
      },
    },
  },
  config = function(_, opts)
    local enabled = opts.sources.completion.enable_providers
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend("force", {
        name = source,
        module = "blink.compat.source",
      }, opts.sources.providers[source] or {})
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    for _, provider in pairs(opts.sources.providers or {}) do
      if provider.kind then
        require("blink.cmp.types").CompletionItemKind[provider.kind] =
          provider.kind
        local transform_items = provider.transform_items
        provider.transform_items = function(ctx, items)
          items = transform_items and transform_items(ctx, items) or items
          for _, item in ipairs(items) do
            item.kind = provider.kind or item.kind
          end
          return items
        end
      end
    end

    require("blink.cmp").setup(opts)
  end,
}
