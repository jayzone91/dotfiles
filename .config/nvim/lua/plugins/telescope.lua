return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim", 
      build = "make", 
    },
  },
  lazy = false,
  config = function()
    require("telescope").setup({
      pickers = {
        find_files = {
          theme = "ivy",
        },
      },
      extensions = {
        fzf = {},
      },
    })

    require("telescope").load_extension("fzf")

    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {desc = "Find Files"})
    vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, {desc = "Find Helptags"})
    vim.keymap.set("n", "<leader>fm", require("config.telescope.multigrep"), {desc = "Multi Grep"})
    vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, {desc = "Live Grep"})
    vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, {desc = "Open buffers"})
  end,
}
