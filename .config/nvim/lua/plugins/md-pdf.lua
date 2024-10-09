return {
  "arminveres/md-pdf.nvim",
  branch = "main",
  lazy = true,
  keys = {
    {
      "<leader>tp",
      function()
        require("md-pdf").convert_md_to_pdf()
      end,
      desc = "Create PDF from Markdown",
      mode = "n",
    },
  },
  opts = {},
}
