return {
  "smiteshp/nvim-navic",
  lazy = true,
  config = function()
    require("nvim-navic").setup({
      lsp = {
        auto_attach = true,
        preference = {
          "html",
          "templ",
        },
      },
      separator = " 󰁔 ",
      highlight = true,
      depth_limit = 5,
      lazy_update_context = true,
    })
  end,
}
