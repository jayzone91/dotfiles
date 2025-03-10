return {
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
      "folke/snacks.nvim",
    },
    build = "go install github.com/lotusirous/gostdsym/stdsym@latest",
    cmd = { "GoDoc" },
    opts = {
      picker = {
        type = "snacks",
      },
    },
    keys = {
      { "<leader>gd", ":GoDoc<CR>", desc = "Go Docs" },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = "ray-x/guihua.lua",
    config = function()
      require("go").setup({
        remap_commands = { GoDoc = false },
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
