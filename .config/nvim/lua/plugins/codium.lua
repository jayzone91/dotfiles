return {
  "Exafunction/codeium.nvim",
  cmd = "Codeium",
  event = "InsertEnter",
  build = ":Codeium Auth",
  opts = {
    enable_cmp_source = true,
    virtal_text = {
      enabled = true,
      key_bindings = {
        accept = false, -- handled by blink.cmp
        next = "<Tab>",
        prev = "<S-Tab>",
      },
    },
  },
}
