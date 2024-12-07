return {
  "saghen/blink.cmp",
  lazy = false,
  version = "v0.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    keymap = {
      preset = "enter",
    },
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    windows = {
      autocomplete = {
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },
    },
    sources = {
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
  nerd_font_variant = "normal",
  accept = { auto_brackets = { enabled = true } },
  trigger = { signature_help = { enabled = true } },
}
