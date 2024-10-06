return {
  "aliqyan-21/wit.nvim",
  config = function()
    require("wit").setup({
      engine = "google",
      command_search = "WitSearch",
      command_search_wiki = "WitSearchWiki",
      command_search_visual = "WitSearchVisual",
    })
    vim.keymap.set("n", "<leader>ws", ":WitSearch<space>", { desc = "Web Search" })
  end,
}
