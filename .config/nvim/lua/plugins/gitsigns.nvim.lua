return {
  "lewis6991/gitsigns.nvim",
  ---@module "gitsigns"
  ---@type Gitsigns.config
  opts = {
    signcolumn = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_align = "right_align",
      ignore_whitespace = false,
    },
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
  },
}
