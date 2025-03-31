return {
	"tjdevries/express_line.nvim",
	config = function()
		local builtins = require("el.builtin")
		local extensions = require("el.extensions")
		local subscribe = require("el.subscribe")
		local sections = require("el.sections")

		vim.opt.laststatus = 3

		require("el").setup({
			generator = function()
				local segments = {}

				table.insert(segments, extensions.mode)
				table.insert(segments, " ")
				table.insert(
					segments,
					subscribe.buf_autocmd("el-git-branch", "BufEnter", function(win, buf)
						local branch = extensions.git_branch(win, buf)
						if branch then
							return branch
						end
					end)
				)
				table.insert(
					segments,
					subscribe.buf_autocmd("el-git-changes", "BufWritePost", function(win, buf)
						local changes = extensions.git_changes(win, buf)
						if changes then
							return changes
						end
					end)
				)
				table.insert(segments, sections.split)
				table.insert(segments, "%f")
				table.insert(segments, builtins.modified)
				table.insert(segments, sections.split)
				table.insert(
					segments,
					subscribe.buf_autocmd("el-file-icon", "BufRead", function(_, buf)
						return extensions.file_icon(_, buf) .. " "
					end)
				)
				table.insert(segments, builtins.filetype)
				table.insert(segments, " ")
				table.insert(segments, "[")
				table.insert(segments, builtins.line_with_width(3))
				table.insert(segments, ":")
				table.insert(segments, builtins.column_with_width(2))
				table.insert(segments, "]")

				return segments
			end,
		})
	end,
}
