-- Autocommands

local function augroup(name)
  return vim.api.nvim_create_augroup("jay_" .. name, { clear = true })
end

-- Check if we need to reload the file when changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on Yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Close some Filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "grug-far",
    "help",
    "lspinfo",
    "notify",
    "telescope",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
    "gitsigns-blame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("ts_imports"),
  pattern = { "*.ts", "*.tsx" },
  callback = function()
    vim.lsp.buf.code_action({
      apply = true,
      ---@diagnostic disable-next-line
      context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
    })
    vim.lsp.buf.code_action({
      apply = true,
      ---@diagnostic disable-next-line
      context = { only = { "source.organizeImports" }, diagnostics = {} },
    })
    vim.lsp.buf.code_action({
      apply = true,
      ---@diagnostic disable-next-line
      context = { only = { "source.removeUnusedImports" }, diagnostics = {} },
    })
    vim.lsp.buf.code_action({
      apply = true,
      ---@diagnostic disable-next-line
      context = { only = { "source.removeUnused.ts" }, diagnostics = {} },
    })
    vim.lsp.buf.code_action({
      apply = true,
      ---@diagnostic disable-next-line
      context = { only = { "source.sortImports" }, diagnostics = {} },
    })
  end,
})
