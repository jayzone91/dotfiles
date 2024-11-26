function get_setup(name)
  return function()
    require("setup." .. name)
  end
end

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim", "williamboman/mason-lspconfig.nvim" },
    config = get_setup("mason"),
  },
  { "rebelot/kanagawa.nvim", config = get_setup("themes/kanagawa"), priority = 1000, lazy = false },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "stevearc/oil.nvim", event = "VeryLazy", config = get_setup("oil") },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = get_setup("conform"),
  },
  { "mbbill/undotree" },
  { "LudoPinelli/comment-box.nvim", event = "VeryLazy" },
  { "numToStr/Comment.nvim", lazy = false, config = get_setup("Comment") },
  { "rlane/pounce.nvim", config = get_setup("pounce") },
  {
    "nvim-lualine/lualine.nvim",
    config = get_setup("lualine"),
    event = "VeryLazy",
  },
  {
    "folke/zen-mode.nvim",
    config = get_setup("zen-mode"),
    event = "VeryLazy",
  },
  {
    "folke/which-key.nvim",
    config = get_setup("which-key"),
    event = "VeryLazy",
  },
  { "brenoprata10/nvim-highlight-colors", config = get_setup("highlight-colors") },
  {
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  { "rcarriga/nvim-notify", config = get_setup("notify") },
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.6.1",
    opts = require("setup.blink"),
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = get_setup("gitsigns"),
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { 
          library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } 
          },
        } 
      },
      dependencies = {
        { "Bilal2453/luvit-meta", lazy = true },
      }
      },
    },
    config = get_setup("lsp"),
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = get_setup("fzf"),
  },
  { "echasnovski/mini.ai", config = get_setup("mini-ai"), version = false },
  { "echasnovski/mini.bracketed", config = get_setup("mini-bracketed"), version = false },
  { "echasnovski/mini.bufremove", config = get_setup("mini-bufremove"), version = false },
  { "echasnovski/mini.indentscope", config = get_setup("mini-indentscope"), version = false, event = "VeryLazy" },
  { "echasnovski/mini.move", config = get_setup("mini-move"), version = false },
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
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
  { "EdenEast/nightfox.nvim", config = get_setup("nightfox"), enabled = false },
  { "folke/tokyonight.nvim", config = get_setup("tokyonight"), enabled = false },
  { "catppuccin/nvim", name = "catppuccin", config = get_setup("catppuccin"), enabled = false },
}
