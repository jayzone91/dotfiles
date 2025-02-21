local path = require("fzf-lua.path")
get_line_and_path = function(selected, opts)
  local file_and_path = path.entry_to_file(selected[1], opts).stripped
  vim.print(file_and_path)
  if vim.o.clipboard == "unnamed" then
    vim.fn.setreg([[*]], file_and_path)
  elseif vim.o.clipboard == "unnamedplus" then
    vim.fn.setreg([[*]], file_and_path)
  else
    vim.fn.setref([[*]], file_and_path)
  end
  -- copy to the yank register regardless
  vim.fn.setreg([[0]], file_and_path)
end

local fzf = require("fzf-lua")

fzf.setup({
  "border-fused",
  fzf_opts = { ["--wrap"] = true },
  previewers = {
    builtin = {
      syntax_limit_b = -102400,
    },
  },
  winopts = {
    preview = {
      wrap = true,
    },
  },
  grep = {
    rg_glob = true,
    ---@return string, string?
    rg_glob_fn = function(query, opts)
      local regex, flags = query:match("^(.-)%s%-%-(.*)$")
      -- if no separator is detected will return the original query
      return (regex or query), flags
    end,
  },
  defaults = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
    formatter = "path.filename_first",
  },
  actions = {
    files = {
      true,
      ["ctrl-y"] = { fn = get_line_and_path, exec_silent = true },
    },
  },
})

-- Mappings

local function map(mode, key, func, opts)
  return vim.keymap.set(mode, key, func, opts)
end

map("n", "<leader>ff", fzf.files, { desc = "FZF Files" })
map("n", "<leader>fk", fzf.keymaps, { desc = "Search Keymaps" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Live Grep" })
map("n", "<leader><space>", fzf.buffers, { desc = "Search Buffers" })
map("n", "<leader>s", fzf.spell_suggest, { desc = "Spelling Suggestions" })
