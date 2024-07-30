return {
  "kosayoda/nvim-lightbulb",
  enabled = false,
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = {
        enabled = true,
      },
    })
  end,
}
