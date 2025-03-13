return {
  "jayzone91/present.nvim",
  ft = "markdown",
  config = function()
    vim.keymap.set(
      "n",
      "<leader>sp",
      ":PresentStart<CR>",
      { desc = "Start Presentation" }
    )
  end,
}
