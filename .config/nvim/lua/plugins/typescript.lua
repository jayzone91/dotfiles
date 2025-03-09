return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = {
    "javascript",
    "typescript",
    "typescriptreact",
    "javascriptreact",
    "typescript.tsx",
    "javascript.jsx",
  },
  config = function()
    require("typescript-tools").setup({
      settings = {
        complete_function_calls = true,
        code_lens = "all",
      },
    })

    vim.keymap.set(
      "n",
      "<leader>to",
      ":TSToolsOrganizeImports<CR>",
      { desc = "TS Organize Imports" }
    )
    vim.keymap.set(
      "n",
      "<leader>ts",
      ":TSToolsSortImports<CR>",
      { desc = "TS Sort Imports" }
    )
    vim.keymap.set(
      "n",
      "<leader>tr",
      ":TSToolsRemoveUnusedImports<CR>",
      { desc = "TS Remove Unused Imports" }
    )
    vim.keymap.set(
      "n",
      "<leader>ta",
      ":TSToolsAddMissingImports<CR>",
      { desc = "TS Add Missing Imports" }
    )
    vim.keymap.set(
      "n",
      "<leader>tf",
      ":TSToolsFixAll<CR>",
      { desc = "TS Fix All" }
    )
    vim.keymap.set(
      "n",
      "<leader>tg",
      ":TSToolsGoToSourceDefinition<CR>",
      { desc = "TS Go to Source Definition" }
    )
  end,
}
