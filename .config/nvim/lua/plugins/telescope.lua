return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    "danielvolchek/tailiscope.nvim",
    {
      "ryanmsnyder/toggleterm-manager.nvim",
      config = function()
        local toggleterm_manager = require("toggleterm-manager")
        local actions = toggleterm_manager.actions
        toggleterm_manager.setup({
          titles = {
            prompt = "Pick Term",
            results = "Terminals",
          },
          mappings = {
            i = {
              ["<CR>"] = {
                action = actions.create_and_name_term,
                exit_on_action = true,
              },
              ["<C-d>"] = {
                action = actions.delete_term,
                exit_on_action = false,
              },
            },
            n = {
              ["<CR>"] = {
                action = actions.create_and_name_term,
                exit_on_action = true,
              },
              ["x"] = { action = actions.delete_term, exit_on_action = false },
            },
          },
        })
      end,
    },
    {
      "nvim-telescope/telescope-media-files.nvim",
      dependencies = {
        "nvim-lua/popup.nvim",
      },
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = function()
        local install_path = vim.fn.stdpath("data")
          .. "/lazy/telescope-fzf-native.nvim"
        vim.cmd("silent !cd " .. install_path .. " && make")
      end,
    },
    {
      "stevearc/dressing.nvim",
      lazy = true,
      init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.input(...)
        end
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    local function flash(prompt_bufnr)
      require("flash").jump({
        pattern = "^",
        label = { after = { 0, 0 } },
        search = {
          mode = "search",
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
                ~= "TelescopeResults"
            end,
          },
        },
        action = function(match)
          local picker =
            require("telescope.actions.state").get_current_picker(prompt_bufnr)
          picker:set_selection(match.pos[1] - 1)
        end,
      })
    end

    local select_one_or_multi = function(prompt_bufnr)
      local picker =
        require("telescope.actions.state").get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if not vim.tbl_isempty(multi) then
        require("telescope.actions").close(prompt_bufnr)
        for _, j in pairs(multi) do
          if j.path ~= nil then
            vim.cmd(string.format("%s %s", "edit", j.path))
          end
        end
      else
        require("telescope.actions").select_default(prompt_bufnr)
      end
    end

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        media_files = {
          find_cmd = "rg",
        },
        tailiscope = {
          register = "a",
          default = "base",
          doc_icon = " ",
          no_dot = true,
          maps = {
            i = {
              back = "<C-b>",
              open_doc = "<C-o>",
            },
            n = {
              back = "b",
              open_doc = "o",
            },
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
        },
      },
      defaults = {
        hidden = true,
        prompt_prefix = " ",
        selection_caret = " ",
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
            reverse_directions = true,
          },
        },
        mappings = {
          i = {
            ["<cr>"] = select_one_or_multi,
          },
          n = {
            ["s"] = flash,
            ["q"] = actions.close,
          },
        },
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "media-files")
    pcall(require("telescope").load_extension, "ui-select")

    -- mappings
    local map = function(modes, lhs, rhs, options)
      local full_options = { silent = true }
      if options then
        full_options = vim.tbl_extend("force", full_options, options)
      end
      if type(modes) == "string" then
        modes = { modes }
      end
      for _, mode in ipairs(modes) do
        vim.keymap.set(mode, lhs, rhs, full_options)
      end
    end

    map(
      "n",
      "<leader>tm",
      ":Telescope toggleterm_manager<CR>",
      { desc = "Manage Terminals" }
    )
    map("n", "<leader>fm", function()
      require("telescope").extensions.media_files.media_files()
    end, { desc = "Media Files" })
    map(
      "n",
      "<leader>ff",
      "<cmd>Telescope find_files<CR>",
      { desc = "Fuzzy Find Files" }
    )
    map(
      "n",
      "<leader>fg",
      "<cmd>Telescope live_grep<CR>",
      { desc = "Live Grep" }
    )
    map(
      "n",
      "<leader><space>",
      "<cmd>Telescope buffers<CR>",
      { desc = "Search Buffers" }
    )
    map(
      "n",
      "<leader>fo",
      "<cmd>Telescope oldfiles<CR>",
      { desc = "Search Recent Files" }
    )
    local utils = require("utils")
    map("n", "<leader>df", function()
      utils.telescope_diff_file()
    end, { desc = "Diff file with current buffer" })
    map("n", "<leader>dr", function()
      utils.telescope_diff_file(true)
    end, { desc = "Diff recent file with current buffer" })
    map("n", "<leader>dg", function()
      utils.telescope_diff_from_history()
    end, { desc = "Diff from git history" })
  end,
}
