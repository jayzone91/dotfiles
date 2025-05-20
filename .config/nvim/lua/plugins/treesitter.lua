return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      textobjectx = {
        select = {
          enable = true,
          lookahead = true,
          include_surrounding_whitespace = true,
        },
      },
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "elixir",
        "heex",
        "javascript",
        "html",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      highlight = { enabled = true },
      indent = { enabled = true },
    })
  end,
}
