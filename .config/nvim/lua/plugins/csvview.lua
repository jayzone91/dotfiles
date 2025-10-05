return {
  "hat0uma/csvview.nvim",
  ---@module "csvview",
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
    jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
    jump_next_row = { "<Enter>", mode = { "n", "v" } },
    jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  keys = {
    { "<leader>tc", ":CsvViewToggle<CR>", desc = "Toggle CSV View" },
  },
}
