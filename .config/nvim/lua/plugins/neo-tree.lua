return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  config = function()
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define(
      "DiagnosticSignError",
      { text = " ", texthl = "DiagnosticSignError" }
    )
    vim.fn.sign_define(
      "DiagnosticSignWarn",
      { text = " ", texthl = "DiagnosticSignWarn" }
    )
    vim.fn.sign_define(
      "DiagnosticSignInfo",
      { text = " ", texthl = "DiagnosticSignInfo" }
    )
    vim.fn.sign_define(
      "DiagnosticSignHint",
      { text = "󰌵", texthl = "DiagnosticSignHint" }
    )

    require("neo-tree").setup({
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
      sort_case_insensitive = true,
      window = {
        position = "float",
      },
    })

    vim.keymap.set(
      "n",
      "<leader>e",
      "<cmd>Neotree toggle<CR>",
      { desc = "Toggle File Explorer" }
    )
  end,
}
