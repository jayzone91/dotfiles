return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "danielfalk/smart-open.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "xiyaowong/telescope-emoji.nvim",
    "ziontee113/icon-picker.nvim",
  },
  keys = {
    {
      "<leader>ff",
      "<cmd>Telescope find_files<CR>",
      { desc = "Telescope Find Files" },
    },
    {
      "<leader>fg",
      "<cmd>Telescope live_grep<CR>",
      { desc = "Telescope Live Grep" },
    },
    {
      "<leader><space>",
      "<cmd>Telescope buffers<CR>",
      { desc = "Telescope Buffers" },
    },
    {
      "<leader>fh",
      "<cmd>Telescope help_tags<CR>",
      { desc = "Telescope Help Tags" },
    },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        smart_open = {
          match_algorithm = "fzf",
        },
      },
      pickers = {
        buffers = {
          theme = "dropdown",
          previewer = false,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
          },
        },
      },
      defaults = {
        hidden = true,
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",

        sorting_strategy = "ascending",
        layout_strategy = "horizontal",

        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        path_display = {
          filename_first = {
            reverse_directories = true,
          },
        },
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "emoji")
    require("icon-picker").setup({
      disable_lagacy_commands = true,
    })

    vim.keymap.set(
      "n",
      "<leader>fn",
      "<cmd>Telescope node_modules list<CR>",
      { desc = "Search Node Modules" }
    )
    vim.keymap.set(
      "n",
      "<leader>fe",
      "<cmd>Telescope emoji<CR>",
      { desc = "Search Emoji" }
    )
    vim.keymap.set(
      "n",
      "<leader>fi",
      "<cmd>IconPickerNormal<CR>",
      { desc = "Find Icons", noremap = true, silent = true }
    )
  end,
}
