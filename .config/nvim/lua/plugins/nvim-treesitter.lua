return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "astro",
      "bash",
      "c",
      "css",
      "comment",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "prisma",
      "ninja",
      "rst",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
  },
  config = function(_, opts)
    local TS = require("nvim-treesitter")

    local install_dir = vim.fn.stdpath("data") .. "/site"

    if not (vim.uv or vim.loop).fs_stat(install_dir) then
      vim.fn.mkdir(install_dir)
    end

    TS.setup({
      install_dir = install_dir,
    })

    local installed = TS.get_installed()

    local ensure_installed = {}

    local function has_value(tab, val)
      for _, value in ipairs(tab) do
        if value == val then
          return true
        end
      end
      return false
    end

    for _, lang in ipairs(opts.ensure_installed) do
      if not has_value(installed, lang) then
        table.insert(ensure_installed, lang)
      end
    end

    TS.install(ensure_installed)

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      if not vim.treesitter.language.add(language) then
        return
      end

      vim.treesitter.start(buf, language)

      local has_indent_query = vim.treesitter.query.get(language, "indent") ~= nil

      if has_indent_query then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    local available_parsers = TS.get_available()

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then
          return
        end

        local installed_parsers = require("nvim-treesitter").get_installed("parsers")

        if vim.tbl_contains(installed_parsers, language) then
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          TS.install(language):await(function()
            treesitter_try_attach(buf, language)
          end)
        else
          treesitter_try_attach(buf, language)
        end
      end,
    })
  end,
}
