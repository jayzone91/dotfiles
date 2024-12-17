-- Edgy Recommended Settings
-- views can only be fully collapsed with the global statusline
vim.o.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.o.splitkeep = "screen"

return {
  "nvim-tree/nvim-web-devicons",
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  { "stevearc/dressing.nvim", opts = {} },
  {
    "folke/todo-comments.nvim",
    opts = {},
    keys = {
      { "<leader>xt", "<cmd>Trouble todo<CR>", desc = "Todos Trouble" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Todos Telescope" },
    },
  },
  { "folke/edgy.nvim", event = "VeryLazy", opts = {} },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  { "b0o/SchemaStore.nvim", version = false },
}
