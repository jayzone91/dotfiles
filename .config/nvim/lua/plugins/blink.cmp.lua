return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end,
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
  },
  event = "VimEnter",
  version = "1.*",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    snippets = { preset = "luasnip" },
    keymap = {
      preset = "enter",
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },
    fuzzy = { implementation = "lua" },
    signature = { enabled = true },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
}
