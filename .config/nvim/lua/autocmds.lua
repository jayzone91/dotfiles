local function augroup(name)
  return vim.api.nvim_create_augroup("jay_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if we need to reload the file when it changed",
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

autocmd({ "VimResized" }, {
  desc = "resize splits if window got resized",
  group = augroup("resize_split"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

autocmd("FileType", {
  desc = "disable commenting next line",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "close some filetypes with <q>",
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "make it easier to close man-files when opened inline",
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "open help in vertical split",
  pattern = "help",
  command = "wincmd L",
})

vim.api.nvim_create_autocmd("BufReadPre", {
  desc = "syntax highlighting for dotenv files",
  group = augroup("dotenv"),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})

local cursorline_group = augroup("active_cursorline")
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  desc = "show cursorline only in active window enable",
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  desc = " show cursorline only in active window diable",
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

local highlight_group = augroup("highlight_lsp_ref")
vim.api.nvim_create_autocmd("CursorMoved", {
  desc = "highlight when stopping cursor",
  group = highlight_group,
  callback = function()
    if vim.fn.mode() ~= "i" then
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local supports_highlight = false
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          supports_highlight = true
          break
        end
      end

      if supports_highlight then
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    end
  end,
})

vim.api.nvim_create_autocmd("CursorMovedI", {
  desc = "clear highlights",
  group = highlight_group,
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})
