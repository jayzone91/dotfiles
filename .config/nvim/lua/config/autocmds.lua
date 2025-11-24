-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("jay_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  desc = "disable commenting next line",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

autocmd("FileType", {
  desc = "open help in vertical split",
  pattern = "help",
  command = "wincmd L",
})

autocmd("BufReadPre", {
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
