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

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treeshitter", { clear = true }),
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end,
    })
  end,
}
