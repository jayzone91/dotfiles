local ok, snacks = pcall(require, "snacks")
if not ok then
  return
end

snacks.setup({
  animate = { enabled = false },
  bigfile = { enabled = true },
  bufdelete = { enabled = true },
  dashboard = { enabled = false },
  debug = { enabled = false },
  dim = { enabled = false },
  explorer = { enabled = true },
  gh = { enabled = false },
  git = { enabled = false },
  gitbrowse = { enabled = false },
  image = { enabled = false },
  indent = { enabled = true },
  input = { enabled = true },
  keymap = { enabled = true },
  layout = { enabled = false },
  lazygit = { enabled = false },
  notifier = { enabled = true, timeout = 3000 },
  notify = { enabled = true },
  picker = { enabled = true, sources = { explorer = { auto_close = true } } },
  profiler = { enabled = false },
  quickfile = { enabled = true },
  rename = { enabled = true },
  scope = { enabled = true },
  scratch = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  terminal = { enabled = false },
  toggle = { enabled = true },
  util = { enabled = true },
  win = { enabled = true },
  words = { enabled = true },
  zen = { enabled = false },
  styles = {
    notifications = { wo = { wrap = true } },
  },
})

vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.buffers()
end, { desc = "Show Buffers" })
vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function()
  Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Explorer" })
vim.keymap.set("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "GOTO Definition" })
vim.keymap.set("n", "gD", function()
  Snacks.picker.lsp_declarations()
end, { desc = "GOTO Declaration" })
vim.keymap.set("n", "gr", function()
  Snacks.picker.lsp_references()
end, { desc = "References" })
