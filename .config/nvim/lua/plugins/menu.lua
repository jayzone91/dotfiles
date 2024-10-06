return {
  "nvchad/menu",
  dependencies = {
    { "nvchad/volt", lazy = true },
  },
  config = function()
    vim.keymap.set("n", "<leader>ft", function()
      require("menu").open("default", { mouse = false, border = false })
    end, { desc = "Toggle Menu" })
    vim.keymap.set("n", "<RightMouse>", function()
      vim.cmd.exec('"normal! \\<RightMouse>"')
      local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
      require("menu").open(options, { mouse = true })
    end)
  end,
}
