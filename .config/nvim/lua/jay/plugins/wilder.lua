return {
  "gelguy/wilder.nvim",
  config = function()
    local wilder = require("wilder")

    wilder.setup({
      modes = { ":", "/", "?" },
    })

    wilder.set_option(
      "renderer",
      wilder.wildmenu_renderer({
        highlighter = wilder.basic_highlighter(),
        seperator = " . ",
        left = { " ", wilder.wildmenu_spinner(), " " },
        right = { " ", wilder.wildmenu_index() },
      })
    )
  end,
}
