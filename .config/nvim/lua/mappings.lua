local km = vim.keymap

local function close_floating()
	for _, win in pairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative == "win" then
			vim.api.nvim_win_close(win, false)
		end
	end
end

km.set("n", "<c-s>", "<cmd>:w<cr>", {desc = "Save File"})

--nav buddy
km.set({ "n" }, "<leader>xb", ":lua require('nvim-navbuddy').open()<cr>", { desc = "Nav Buddy" })

km.set("n", "<esc>", function()
  close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

-- Easy delete buffer without losing window split
km.set("n", "<leader>d", ":lua MiniBufremove.delete()<cr>", { silent = true, desc = "Mini Bufremove" })

-- Easy add date/time
function date()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_feedkeys("o", "n", true)
end

km.set("n", "<Leader>xd", "<cmd>lua date()<cr>", { desc = "Insert Date" })

km.set("n", "<leader>p", require("fzf-lua").files, { desc = "FZF Files" })


km.set("n", "<leader>r", require("fzf-lua").registers, { desc = "Registers" })

km.set("n", "<leader>m", require("fzf-lua").marks, { desc = "Marks" })

km.set("n", "<leader>k", require("fzf-lua").keymaps, { desc = "Keymaps" })

km.set("n", "<leader>f", require("fzf-lua").files, {desc = "Find files"})

km.set("n", "<leader>l", require("fzf-lua").live_grep, { desc = "FZF Grep" })

km.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "FZF Buffers" })

km.set("v", "<leader>8", require("fzf-lua").grep_visual, { desc = "FZF Selection" })

km.set("n", "<leader>7", require("fzf-lua").grep_cword, { desc = "FZF Word" })

km.set("n", "<leader>j", require("fzf-lua").helptags, { desc = "Help Tags" })

km.set("n", "<leader>gc", require("fzf-lua").git_bcommits, { desc = "Browse File Commits" })

km.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })

km.set("n", "<leader>s", require("fzf-lua").spell_suggest, { desc = "Spelling Suggestions" })

km.set("n", "<leader>cj", require("fzf-lua").lsp_definitions, { desc = "Jump to Definition" })

km.set(
  "n",
  "<leader>cs",
  ":lua require'fzf-lua'.lsp_document_symbols({winopts = {preview={wrap='wrap'}}})<cr>",
  { desc = "Document Symbols" }
)


km.set("n", "<leader>cr", require("fzf-lua").lsp_references, { desc = "LSP References" })

km.set(
  "n",
  "<leader>cd",
  ":lua require'fzf-lua'.diagnostics_document({fzf_opts = { ['--wrap'] = true }})<cr>",
  { desc = "Document Diagnostics" }
)

km.set(
  "n",
  "<leader>ca",
  ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
  { desc = "Code Actions" }
)

km.set("n", "k", function()
  vim.lsp.buf.hover()
end, { desc = "Code Hover" })

km.set("n", "<leader>cl", function()
  vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Line Diagnostics" })

km.set({ "v", "n" }, "<leader>cn", function()
  vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "Code Rename" })

km.set("n", "<Leader><Down>", "<C-W><C-J>", { silent = true, desc = "Window Down" })
km.set("n", "<Leader><Up>", "<C-W><C-K>", { silent = true, desc = "Window Up" })
km.set("n", "<Leader><Right>", "<C-W><C-L>", { silent = true, desc = "Window Right" })
km.set("n", "<Leader><Left>", "<C-W><C-H>", { silent = true, desc = "Window Left" })
km.set("n", "<Leader>wr", "<C-W>R", { silent = true, desc = "Window Resize" })
km.set("n", "<Leader>=", "<C-W>=", { silent = true, desc = "Window Equalise" })


-- Easier window switching with leader + Number
-- Creates mappings like this: km.set("n", "<Leader>2", "2<C-W>w", { desc = "Move to Window 2" })
for i = 1, 4 do
  local lhs = "<Leader>" .. i
  local rhs = i .. "<C-W>w"
  km.set("n", lhs, rhs, { desc = "Move to Window " .. i })
end

km.set({ "n", "v" }, "h", ":Pounce<CR>", { silent = true, desc = "Pounce" })
km.set("n", "H", ":PounceRepeat<CR>", { silent = true, desc = "Pounce Repeat" })


-- thanks to https://www.reddit.com/r/neovim/comments/107g7yf/comment/j3o5a6f/?context=3 we can toggle the line mode changes in our options due to the correct variable being set here
km.set("n", "<leader>z", function()
  if vim.g.zen_mode_active then
    require("zen-mode").toggle()
    vim.g.zen_mode_active = false
  else
    require("zen-mode").toggle()
    vim.g.zen_mode_active = true
  end
end, { desc = "Zen Mode Toggle" })

km.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Quick new split above/below
km.set({ "n" }, "<Leader>ws", "<CMD>new<CR>", { desc = "New split below" })
km.set({ "n" }, "<Leader>wv", "<CMD>vnew<CR>", { desc = "New split right" })


-- Word Count
km.set({ "n" }, "<Leader>xw", function()
  return require("notify")(wordCount.getWords(), "info", {
    icon = "󰆙 ",
    title = "Word Count",
    timeout = 1000,
    render = "wrapped-compact",
    top_down = true,
    opts = {
      max_width = 10,
    },
  })
end, { desc = "Word Count" })
