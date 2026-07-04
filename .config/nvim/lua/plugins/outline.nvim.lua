return {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    {
      "<leader>o",
      "<cmd>Outline<CR>",
      desc = "Toggle Outline",
    },
  },
  opts = {
    outline_window = {
      position = "right",
      width = 28,
    },
    symbols = {
      filter = {
        default = {
          "String",
          "Number",
          "Boolean",
          "Array",
          "Object",
          "Key",
          "Null",
        },
      },
    },
  },
}
