return {
  "neovim/nvim-lspconfig",
  priority = 1,
  lazy = true,
  event = { "BufEnter", "BufNew" },
  dependencies = {
    -- Automatic installation of LSPs
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "b0o/SchemaStore.nvim",

    -- Just for the keybinds
    "nvim-telescope/telescope.nvim",

    -- Snipped Support
    "hrsh7th/nvim-cmp", -- Autocompletion plugin
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
    "L3MON4D3/LuaSnip", -- Snippets plugin

    -- Fancy LSP Progress
    {
      "j-hui/fidget.nvim",
      opts = {},
    },

    -- Fancy Error Lines
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

    -- Faster LuaLS setup for NeoVim
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      cmd = "LazyDev",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
      dependencies = {
        "Bilal2453/luvit-meta",
        lazy = true,
      },
    },
  },
  -- Start Config Function
  config = function()
    require("config.lsp")
  end,
}
