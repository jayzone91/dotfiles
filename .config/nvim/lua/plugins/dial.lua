return {
  "monaqa/dial.nvim",
  recommended = true,
  desc = "Increment and decrement numbers, dates and more",
  keys = {
    {
      "+",
      function()
        require("dial.map").manipulate("increment", "normal")
      end,
      expr = true,
      desc = "Increment",
      mode = { "n" },
    },
    {
      "-",
      function()
        require("dial.map").manipulate("decrement", "normal")
      end,
      expr = true,
      desc = "Decrement",
      mode = { "n" },
    },
  },
  opts = function()
    local augend = require("dial.augend")
    local logical_alias = augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    })
    local ordinal_numbers = augend.constant.new({
      elements = {
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
      },
      word = false,
      cyclic = true,
    })

    local weekdays = augend.constant.new({
      elements = {
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      },
      word = true,
      cyclic = true,
    })
    local german_weekdays = augend.constant.new({
      elements = {
        "Montag",
        "Dienstag",
        "Mittwoch",
        "Donnerstag",
        "Freitag",
        "Samstag",
        "Sonntag",
      },
      word = true,
      cyclic = true,
    })
    local months = augend.constant.new({
      elements = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      },
      word = true,
      cyclic = true,
    })
    local german_months = augend.constant.new({
      elements = {
        "Januar",
        "Februar",
        "März",
        "April",
        "Mai",
        "Juni",
        "juli",
        "August",
        "September",
        "Oktober",
        "November",
        "Dezember",
      },
      word = true,
      cyclic = true,
    })
    local capitalized_boolean = augend.constant.new({
      elements = {
        "True",
        "False",
      },
      word = true,
      cyclic = true,
    })

    return {
      dials_by_ft = {
        css = "css",
        javascript = "typescript",
        javascriptreact = "typescript",
        json = "json",
        lua = "lua",
        markdown = "markdown",
        python = "python",
        sass = "css",
        scss = "css",
        typescript = "typescript",
        typescriptreact = "typescript",
        yaml = "yaml",
      },
      groups = {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%d.%m.%Y"],
          ordinal_numbers,
          weekdays,
          german_weekdays,
          months,
          german_months,
        },
        typescript = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
          logical_alias,
          augend.constant.new({ elemets = { "let", "const" } }),
        },
        yaml = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
        },
        css = {
          augend.integer.alias.decimal,
          augend.hexcolor.new({ case = "lower" }),
          augend.hexcolor.new({ case = "upper" }),
        },
        markdown = {
          augend.misc.alias.markdown_header,
        },
        json = {
          augend.integer.alias.decimal,
          augend.semver.alias.semver,
        },
        lua = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
          augend.constant.new({
            elements = { "and", "or" },
            word = true,
            cyclic = true,
          }),
        },
        python = {
          augend.integer.alias.decimal,
          capitalized_boolean,
          logical_alias,
        },
      },
    }
  end,
  config = function(_, opts)
    require("dial").augends:register_group(opts.groups)
    vim.g.dials_by_ft = opts.dials_by_ft
  end,
}
