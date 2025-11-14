return {
  "folke/lazydev.nvim",
  ft = "lua",
  dependencies = {
    { "Bilal2453/luvit-meta", lazy = true },
  },
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
