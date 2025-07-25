return {
  "nvim-neo-tree/neo-tree.nvim",
  ---@module "neo-tree"
  ---@type neotree.Config
  opts = {
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.uv.cwd(),
        })
      end,
      desc = "Explorer NeoTree",
    },
  },
}
