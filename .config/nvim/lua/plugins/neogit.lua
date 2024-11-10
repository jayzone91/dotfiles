return {
  "NeogitOrg/neogit",
  dependencies = { "sindrets/diffview.nvim" },
  config = function()
    local neogit = require("neogit")
    neogit.setup({})
    vim.keymap.set("n", "<leader>go", function()
      neogit.open()
    end, { desc = "Open Neogit" })
    vim.keymap.set("n", "<leader>gs", function()
      neogit.open({ kind = "split" })
    end, { desc = "Open Neogit in Split" })
  end,
}
