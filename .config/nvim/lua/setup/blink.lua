return {
  keymap = {
    preset = "enter",
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    min_keyword_length = function()
      return vim.bo.filetype == "markdown" and 4 or 0
    end,
    providers = {
      lsp = {
        fallbacks = {},
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  completion = {
    documentation = { window = { border = "single" } },
    menu = { border = "single" },
    list = {
      selection = {
        preselect = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
        auto_insert = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
      },
    },
  },
  signature = { window = { border = "single" } },
}
