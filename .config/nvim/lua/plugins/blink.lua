return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  version = "v0.*",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    highlight = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = false,
    },
    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
    windows = {
      autocomplete = {
        winbledn = vim.o.pumblend,
      },
      documentation = {
        auto_show = true,
      },
      ghost_text = {
        enabled = false,
      },
    },
    accepts = { auto_brackets = { enabled = true } },
    sources = {
      -- add lazydev to your completion providers
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
      },
      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lsp = { fallback_for = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
    keymap = { preset = "enter" },
  },
  -- allows extending the enabled_providers array elsewhere in your config
  -- without having to redefining it
  opts_extend = { "sources.completion.enabled_providers" },
}
