return {
  "laytan/tailwind-sorter.nvim",
  ft = {
    "astro",
    "css",
    "elixir",
    "eelixir",
    "heex",
    "html",
    "javascript",
    "javascriptreact",
    "php",
    "scss",
    "templ",
    "twig",
    "typescript",
    "typescriptreact",
  },
  cmd = {
    "TailwindSort",
    "TailwindSortOnSaveToggle",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  build = "cd formatter && npm ci && npm run build",
  opts = {
    on_save_enabled = true,
    on_save_pattern = {
      "*.astro",
      "*.css",
      "*.hbs",
      "*.heex",
      "*.html",
      "*.js",
      "*.jsx",
      "*.php",
      "*.scss",
      "*.templ",
      "*.ts",
      "*.tsx",
      "*.twig",
    },
  },
  config = function(_, opts)
    local parsers = require("nvim-treesitter.parsers")

    -- tailwind-sorter still expects the legacy nvim-treesitter helper.
    if parsers.get_parser == nil then
      parsers.get_parser = vim.treesitter.get_parser
    end

    require("tailwind-sorter").setup(opts)
  end,
}
