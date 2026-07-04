return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon Add File",
    },
    {
      "<leader>hh",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon Menu",
    },
    {
      "<leader>hn",
      function()
        require("harpoon.ui").nav_next()
      end,
      desc = "Harpoon Next",
    },
    {
      "<leader>hp",
      function()
        require("harpoon.ui").nav_prev()
      end,
      desc = "Harpoon Previous",
    },
  },
  opts = {
    global_settings = {
      save_on_toggle = true,
      save_on_change = true,
      mark_branch = true,
    },
  },
}
