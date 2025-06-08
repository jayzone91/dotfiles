return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    {
      "bennypowers/nvim-regexplainer",
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
      opts = {
        auto = true,
        filetypes = {
          "html",
          "js",
          "cjs",
          "mjs",
          "ts",
          "jsx",
          "tsx",
          "cjsx",
          "mjsx",
          "python",
        },
        display = "popup",
        narrative = {
          indendation_string = "> ", -- default '  '
        },
      },
    },
  },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "css",
      "cpp",
      "go",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "query",
      "norg",
      "scss",
      "svelte",
      "typst",
      "vue",
    },
    sync_install = false,
    auto_install = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    require("nvim-ts-autotag").setup({
      opts = {
        enable_icons = true,
        enable_rename = true,
        enbale_close_on_slash = true,
      },
    })
  end,
}
