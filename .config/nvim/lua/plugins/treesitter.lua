return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "apple/pkl-neovim",
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    highlight = { enabled = true, use_languagetree = true },
    indent = { enabled = true },
    additional_vim_regex_highlighting = false,
    ensure_insalled = {
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "laudoc",
      "luap",
      "pkl",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "templ",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    incremental_selection = {
      enable = true,
    },
    auto_install = true,
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

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

    vim.treesitter.language.register("templ", "templ")
  end,
}
