return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
      "html",
      "latex",
      "typst",
      "yaml",
      "dockerfile",
      "git_config",
      "gitcommit",
      "git_rebase",
      "gitignore",
      "gitattributes",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "json5",
      "php",
      "prisma",
      "ninja",
      "rst",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    local parser_config =
      require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade",
    }

    require("nvim-treesitter.configs").setup(opts)

    vim.filetype.add({
      pattern = {
        [".*%blade%.php"] = "blade",
      },
    })

    vim.filetype.add({
      extensions = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
      filename = {
        ["vifrmc"] = "vim",
      },
      pattern = {
        [".*/waybar/config"] = "jsonc",
        [".*/mako/config"] = "dosini",
        [".*/kitty/.+%.conf"] = "kitty",
        [".*/hypr/.+%.conf"] = "hyprlang",
        ["%.env%.[%w_.-]+"] = "sh",
      },
    })
    vim.treesitter.language.register("bash", "kitty")
  end,
}
