local api = vim.api

vim.cmd("au BufRead,BufNewFile *.templ setfiletype templ")
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.templ" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    ---@diagnostic disable-next-line:deprecated
    vim.api.nvim_buf_set_option(buf, "filetype", "templ")
  end,
})

local function augroup(name)
  api.nvim_create_augroup("custom_" .. name, { clear = true })
end

api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_on_yank"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight on Yank",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "close some filetypes with <q>",
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
    "telescope",
    "Telescope",
    "neotree",
    "Neotree",
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
        desc = "Quit Buffer",
      })
    end)
  end,
})

api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})
