return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "Telescope",
		opts = function()
			return {
				defaults = {
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with_filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					previewer = true,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			for _, ext in ipairs(opts.extensions_list) do
				telescope.load_extension(ext)
			end

			local builtins = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtins.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fg", builtins.live_grep, { desc = "Find with Grep" })
			vim.keymap.set("n", "<leader>fb", builtins.buffers, { desc = "Find Buffer" })
			vim.keymap.set("n", "<leader>fh", builtins.help_tags, { desc = "Find Help" })
		end,
	},
}
