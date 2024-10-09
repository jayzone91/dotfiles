return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "Trouble", "qf" },
    sort_case_insensitive = true,
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
      },
    },
    window = {
      position = "left",
      width = 40,
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = true,
        hide_gitignore = true,
        hide_hidden = true,
        hide_by_name = {
          "node_modules",
        },
        always_show_by_pattern = {
          ".env",
          ".gitignore",
        },
        never_show = {
          ".DS_Store",
          "thumps.db",
        },
        never_show_by_pattern = {
          ".null-ls_*",
        },
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    vim.keymap.set(
      "n",
      "<leader>e",
      "<cmd>Neotree position=left toggle<cr>",
      { desc = "Toggle Explorer Sidebar" }
    )
    vim.keymap.set(
      "n",
      "<leader>E",
      "<cmd>Neotree position=float toggle<cr>",
      { desc = "Show Explorer in Floating Window" }
    )
  end,
}
