vim.g.barbar_auto_setup = false -- disable auto-update
return {
  "romgrk/barbar.nvim",
  lazy = false,
  opts = {
    animation = false,
    tabpages = true,
    hide = { extensions = false, inactive = false},
    icons = {
      buffer_index = false,
      buffer_number = false,
      button = '',
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = ' '},
    },
    gitsigns = {
      added = {enabled = true, icon = ' '},
      changed = {enabled = true, icon = ' '},
      deleted = {enabled = true, icon = ' '},
    },
    separator = {left = '▎', right = ''},
    separator_at_end = true,
    modified = {button = '●'},
    pinned = {button = '', filename = true},
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
    },
        Outline = {event = 'BufWinLeave', text = 'symbols-outline', align = 'right'},
  },
  maximum_length = 25
}
