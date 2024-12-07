return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.icons").setup()

    require("mini.pairs").setup()

    require("mini.statusline").setup({
      use_icons = true,
      set_vim_settings = true,
    })

    require("mini.sessions").setup({
      autowrite = true,
      autoread = false,
      directory = "sessions",
      file = "Session.vim",
      force = { read = false, write = true, delete = false },
    })
  end,
}
