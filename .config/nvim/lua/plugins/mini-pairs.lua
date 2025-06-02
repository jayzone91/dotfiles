return {
  {
    "echasnovski/mini.pairs",
    version = false,
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },
    config = function(_, opts)
      require("utils.mini").pairs(opts)
    end,
  },
}
