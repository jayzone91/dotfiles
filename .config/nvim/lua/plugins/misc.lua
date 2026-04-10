local trouble_ok, trouble = pcall(require, "trouble")
if trouble_ok then
  trouble.setup()

  vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
end

local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.setup()
  wk.add({
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  })
end

local gs_ok, gs = pcall(require, "gitsigns")
if gs_ok then
  gs.setup({
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
  })
end

local lualine_ok, ll = pcall(require, "lualine")
if lualine_ok then
  ll.setup({
    icons_enabled = true,
    theme = "auto",
  })
end

local tdc_ok, tdc = pcall(require, "todo-comments")
if tdc_ok then
  tdc.setup()
end

local ap_ok, ap = pcall(require, "nvim-autopairs")
if ap_ok then
  ap.setup()
end

local grug_ok, grug_far = pcall(require, "grug-far")
if grug_ok then
  grug_far.setup({
    headerMaxWidth = 80,
  })

  vim.keymap.set({ "n", "x" }, "<leader>sr", function()
    local grug = require("grug-far")
    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
    grug.open({
      transient = true,
      prefills = {
        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
      },
    })
  end, { desc = "Search and Replace" })
end

local ts_auto_ok, ts_auto = pcall(require, "nvim-ts-autotag")
if ts_auto_ok then
  ts_auto.setup()
end
