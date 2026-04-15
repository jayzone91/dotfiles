return {
  "qwavies/smart-backspace.nvim",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    map_bs = false,
    enabled = true,
    silent = true,
    disabled_filetypes = {
      "py",
      "hs",
      "md",
      "txt",
    },
  },
}
