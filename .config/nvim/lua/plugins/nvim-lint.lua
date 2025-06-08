return {
  "mfussenegger/nvim-lint",
  config = function()
    local linter = require("config.linter")
    require("lint").linters_by_ft = linter
  end,
}
