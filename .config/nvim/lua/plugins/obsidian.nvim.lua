-- TODO: Workspaces einbauen, muss an der Arbeit schauen, wo der Kram ist.

return {
  "obsidian-nvim/obsidian.nvim",
  enabled = false,
  version = "*",
  ft = "markdown",
  ---@module "obsidian"
  ---@type obsidian.config
  opts = {
    workspaces = {},
  },
  keys = {
    { "<leader>on", ":Obsidian new", desc = "Obsidian new note [NAME]" },
    { "<leader>os", ":Obsidian quick_switch<CR>", desc = "Switch Note" },
    { "<leader>of", ":Obsidian search", desc = "Search Note [QUERY]" },
    { "<leader>ow", ":Obsidian workspace", desc = "Switch Workspace [NAME]" },
  },
}
