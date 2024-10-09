return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "stevearc/dressing.nvim", opts = {} },
    { "https://git.sr.ht/~havi/telescope-toggleterm.nvim", event = "TermOpen" },
  },
  config = function()
    require("telescope").setup({
      defaults = {},
      pickers = {},
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "toggleterm")

    local builtin = require("telescope.builtin")
    vim.keymap.set(
      "n",
      "<leader>ff",
      builtin.find_files,
      { desc = "Telescope find files" }
    )
    vim.keymap.set(
      "n",
      "<leader>fg",
      builtin.live_grep,
      { desc = "Telescope live grep" }
    )
    vim.keymap.set("n", "<leader>fw", function()
      builtin.current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        })
      )
    end, { desc = "Telescope Search Current Buffer" })
    vim.keymap.set(
      "n",
      "<leader>fd",
      builtin.diagnostics,
      { desc = "Search Diagnostics" }
    )
    vim.keymap.set(
      "n",
      "<leader><space>",
      builtin.buffers,
      { desc = "Telescope buffers" }
    )
    vim.keymap.set(
      "n",
      "<leader>fh",
      builtin.help_tags,
      { desc = "Telescope help tags" }
    )
    vim.keymap.set(
      "n",
      "<leader>ft",
      "<cmd>Telescope toggleterm<CR>",
      { desc = "Search Terminals" }
    )
  end,
}
