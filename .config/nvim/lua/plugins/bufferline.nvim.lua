return {
  "akinsho/bufferline.nvim",
  lazy = false,
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  ---@module "bufferline"
  ---@type bufferline.UserConfig
  opts = {
    options = {
      close_command = function(n)
        Snacks.bufdelete(n)
      end,
      right_mouse_command = function(n)
        Snacks.bufdelete(n)
      end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "snacks_layout_box",
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
  keys = {
    {
      "<Tab>",
      "<cmd>BufferLineCycleNext<cr>",
      desc = "Next Buffer",
    },
    {
      "<S-Tab>",
      "<cmd>BufferLineCyclePrev<cr>",
      desc = "Prev Buffer",
    },
    {
      "<C-w>",
      function()
        Snacks.bufdelete(0)
      end,
      desc = "Close current Buffer",
    },
  },
}
