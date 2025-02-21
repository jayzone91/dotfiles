local nightfox = require("nightfox")

nightfox.setup({
  options = {
    dim_inactive = true,
    styles = {
      comments = "italic",
      keywords = "bold",
      functions = "italic.bold",
    },
    inverse = {
      search = true,
      match_paren = true,
    },
  },
  groups = {
    all = {
      CursorLine = { bg = "#353A542" },
      CursorColumn = { bg = "#353A542" },
    },
  },
})

vim.cmd("colorscheme duskfox")
