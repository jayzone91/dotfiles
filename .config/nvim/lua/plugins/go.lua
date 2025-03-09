return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        remap_commands = { GoDoc = false },
      })
    end,
  },
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
      { "folke/snacks.nvim" },
    },
    build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
    cmd = { "GoDoc" },
    opts = {
      picker = {
        type = "snacks",
      },
    },
    ft = { "go", "gomod" },
    config = function(_, opts)
      require("godoc").setup(opts)

      vim.keymap.set(
        "n",
        "<leader>sd",
        ":GoDoc<CR>",
        { desc = "Search Go Docks" }
      )
    end,
  },
}
