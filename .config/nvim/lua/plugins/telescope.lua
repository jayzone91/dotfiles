return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope",
  init = function()
    local builtin = require("telescope.builtin")
    local wk = require("which-key")

    wk.add({
      {
        "<leader><space>",
        builtin.buffers,
        desc = "Find Buffers",
      },
      {
        "<leader>ff",
        builtin.find_files,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        builtin.live_grep,
        desc = "Find with grep",
      },
      {
        "<leader>fh",
        builtin.help_tags,
        desc = "Find help",
      },
    })
  end,
  opts = function()
    return {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        previewer = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      },
      extensions = {},
      extensions_list = {},
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)

    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}
