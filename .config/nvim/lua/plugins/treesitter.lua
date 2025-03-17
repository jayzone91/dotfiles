return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  dependencies = {
    "apple/pkl-neovim",
    {
      "windwp/nvim-ts-autotag",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("nvim-ts-autotag").setup({
          opts = {
            -- Defaults
            enable_close = true, -- Auto close tags
            enable_rename = true, -- Auto rename pairs of tags
            enable_close_on_slash = false, -- Auto close on trailing </
          },
          -- Also override individual filetype configs, these take priority.
          -- Empty by default, useful if one of the "opts" global settings
          -- doesn't work well in a specific filetype
          aliases = {
            ["template"] = "html",
          },
        })
      end,
    },
  },
  opts = {
    ensure_installed = {
      "go",
      "lua",
      "pkl",
      "rust",
      "gleam",
      "svelte",
      "typescript",
      "javascript",
      "tsx",
      "php",
      "blade",
      "templ",
      "go",
      "gomod",
      "gowork",
      "gosum",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
    auto_install = true,
    sync_install = false,
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    -- Register the language
    vim.filetype.add({
      extension = {
        templ = "templ",
      },
    })

    -- Make sure we have a tree-sitter grammar for the language
    local treesitter_parser_config =
      require("nvim-treesitter.parsers").get_parser_configs()
    treesitter_parser_config.templ = treesitter_parser_config.templ
      or {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }

    local configs = require("lspconfig.configs")
    if not configs.templ then
      configs.templ = {
        default_config = {
          cmd = { "templ", "lsp" },
          filetypes = { "templ" },
          root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
          settings = {},
        },
      }
    end
  end,
}
