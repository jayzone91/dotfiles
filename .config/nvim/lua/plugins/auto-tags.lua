return {
  "windwp/nvim-ts-autotag",
  lazy = false,
  config = function()
    ---@diagnostic disable-next-line:missing-fields
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      per_filetype = {},
    })
  end,
}
