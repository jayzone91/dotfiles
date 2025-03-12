vim.filetype.add({ extension = { templ = "templ" } })

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
vim.treesitter.language.register("templ", "templ")

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "templ",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html", "templ" },
        },
        htmx = { filetypes = { "html", "templ" } },
        cssls = {},
        tailwindcss = {
          filetypes_include = {
            "templ",
            "javascript",
            "typescript",
            "react",
            "html",
          },
          settings = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
              templ = "html",
            },
          },
        },
        templ = {
          filetypes = { "templ" },
          settings = {
            templ = {
              enable_snippets = true,
            },
          },
          default_config = {
            cmd = { "templ", "lsp" },
            filetypes = { "templ" },
            root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
            settings = {},
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "templ",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        templ = { "templ" },
      },
    },
  },
}
