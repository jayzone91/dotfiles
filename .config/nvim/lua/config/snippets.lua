local ls = require("luasnip")

vim.snippet.expand = ls.lsp_expand

ls.config.set_config = {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  override_builtin = true,
}

for _, ft_path in
  ipairs(vim.api.nvim_get_runtime_file("lua/config/snippets/*.lua", true))
do
  loadfile(ft_path)()
end
