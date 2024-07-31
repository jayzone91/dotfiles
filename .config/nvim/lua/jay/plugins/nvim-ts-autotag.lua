-- https://github.com/windwp/nvim-ts-autotag
return {
  "windwp/nvim-ts-autotag",
  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
    per_filetype = {},
  },
  config = function(_, opts)
    require("nvim-ts-autotag").setup(opts)
  end,
}
