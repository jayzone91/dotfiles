local wk = require("which-key")

wk.setup({
  delay = 0,
  plugins = {
    spelling = { enabled = true },
  },
  icons = {
    rules = false,
    breadcrumb = " ", -- symbol used in the command line area that shows your active key combo
    separator = "󱦰  ", -- symbol used between a key and it's label
    group = "󰹍 ", -- symbol prepended to a group
  },
})
