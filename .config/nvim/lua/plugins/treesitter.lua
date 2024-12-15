return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "prisma",
        "ninja",
        "rst",
        "lua",
        "dockerfile",
        "vim",
        "vimdoc",
        "go",
        "json5",
        "gomod",
        "gowork",
        "gosum",
        "query",
        "markdown",
        "markdown_inline",
      },

      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
