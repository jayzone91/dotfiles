local ok, blink = pcall(require, "blink.cmp")
if not ok then
  return
end

---@module "blink.cmp"
---@type blink.cmp.Config
blink.setup({
  keymap = { preset = "super-tab" },
  appearance = { nerd_font_variant = "mono", use_nvim_cmp_as_default = false },
  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = { enabled = true },
  },
  snippets = { preset = "default" },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
})
