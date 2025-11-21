return {
  "vuki656/package-info.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  ft = "json",
  config = function()
    local colors = require("cyberdream.colors").default
    require("package-info").setup({
      highlights = {
        up_to_date = {
          fg = colors.green,
          bg = colors.bg,
        },
        outdated = {
          fg = colors.orange,
          bg = colors.bg,
        },
        invalid = {
          fg = colors.red,
          bg = colors.bg,
        },
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
