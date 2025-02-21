function get_setup(name)
  return function()
    require("setup." .. name)
  end
end

return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "wakatime/vim-wakatime", lazy = false },
  {
    "nvim-tree/nvim-tree.lua",
    config = get_setup("nvim-tree"),
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = get_setup("mason-tool"),
  },
  {
    "rebelot/kanagawa.nvim",
    config = get_setup("themes/kanagawa"),
    priority = 1000,
    lazy = false,
    enabled = true,
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    config = get_setup("oil"),
    enabled = false,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = get_setup("conform"),
  },
  { "mbbill/undotree" },
  {
    "LudoPinelli/comment-box.nvim",
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = get_setup("lualine"),
    event = "VeryLazy",
  },
  {
    "folke/which-key.nvim",
    config = get_setup("which-key"),
    event = "VeryLazy",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = get_setup("highlight-colors"),
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("setup.snacks"),
  },
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = require("setup.blink"),
    opts_extend = { "sources.default" },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = get_setup("gitsigns"),
  },
  {
    "neovim/nvim-lspconfig",
    config = get_setup("lsp"),
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig",
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = get_setup("fzf"),
  },
  {
    "rmagatti/auto-session",
    config = get_setup("auto-session"),
  },
  {
    "echasnovski/mini.ai",
    config = function()
      require("mini.ai").setup()
    end,
    version = false,
  },
  {
    "echasnovski/mini.bracketed",
    config = function()
      require("mini.bracketed").setup()
    end,
    version = false,
  },
  {
    "echasnovski/mini.move",
    config = get_setup("mini-move"),
    version = false,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    config = get_setup("autopairs"),
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    config = get_setup("nightfox"),
    enabled = false,
  },
  {
    "folke/tokyonight.nvim",
    config = get_setup("tokyonight"),
    enabled = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = get_setup("catppuccin"),
    enabled = false,
  },
}
