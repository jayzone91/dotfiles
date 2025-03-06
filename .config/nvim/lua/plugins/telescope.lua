return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		init = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find File" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find with grep" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
			vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find Buffer" })
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
				extensions = {
					file_browser = {
						theme = "ivy",
						hijack_netrw = true,
					},
				},
				extensions_list = {
					-- "file_browser",
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			-- load extensions
			for _, ext in ipairs(opts.extensions_list) do
				telescope.load_extension(ext)
			end
		end,
	},
	--{
	--   "nvim-telescope/telescope-file-browser.nvim",
	--   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	-- },
}
