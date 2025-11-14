return {
  "vuki656/package-info.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  ft = "json",
  config = function()
    require("package-info").setup({
      colors = {
        up_to_date = require("cyberdream.colors").default.green,
        outdated = require("cyberdream.colors").default.orange,
        invalid = require("cyberdream.colors").default.red,
      },
    })
  end,
  keys = {
    {
      "<leader>ns",
      "<cmd>lua require('package-info').show({force = true})<cr>",
      desc = "Fetch outdated packages",
    },
    {
      "<leader>nd",
      "<cmd>lua require('package-info').delete()<cr>",
      desc = "Delete dependency",
    },
    {
      "<leader>np",
      "<cmd>lua require('package-info').change_version()<cr>",
      desc = "Change dependency version",
    },
    {
      "<leader>ni",
      "<cmd>lua require('package-info').install()<CR>",
      desc = "Install selected dependency",
    },
  },
}
