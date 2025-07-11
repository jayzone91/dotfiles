return {
  "stevearc/oil.nvim",
  ---@module "oil"
  ---@type oil.SetupOpts
  opts = {
    win_options = {
      wrap = false,
      signcolumn = "yes",
    },
    skip_confirm_for_simple_edits = true,
  },
  dependencies = {
    {
      "echasnovski/mini.icons",
      opts = {},
    },
  },
  config = function(_, opts)
    vim.keymap.set("n", "<leader>e", require("oil").toggle_float)
    require("oil").setup(opts)
  end,
}
