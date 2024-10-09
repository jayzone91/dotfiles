return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
    { "petertriho/cmp-git", opts = {} },
    {
      "L3MON4D3/LuaSnip",
      ---@diagnostic disable-next-line:undefined-field
      build = (not vim.uv.os_uname().sysname:find("Windows") ~= nil)
          and "echo 'NOTE: jsregexp ist optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
    },
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    require("config.plugins.cmp")
  end,
}
