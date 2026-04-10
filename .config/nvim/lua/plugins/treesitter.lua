local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
  return
end

local install_dir = vim.fn.stdpath("data") .. "/site"
if not (vim.uv or vim.loop).fs_stat(install_dir) then
  vim.fn.mkdir(install_dir)
end

ts.setup({
  install_dir = install_dir,
})

ts.install({
  "astro",
  "bash",
  "cmake",
  "css",
  "csv",
  "dockerfile",
  "dot",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "html",
  "javascript",
  "json",
  "json5",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "nginx",
  "php",
  "phpdoc",
  "powershell",
  "prisma",
  "python",
  "regex",
  "robots_txt",
  "rust",
  "scss",
  "sql",
  "ssh_config",
  "templ",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "zig",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "<filetype>" },
  callback = function()
    vim.treesitter.start()
  end,
})
