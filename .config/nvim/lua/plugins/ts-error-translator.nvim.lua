-- Plugin: dmmulroy/ts-error-translator.nvim
-- Installed via store.nvim

return {
  "dmmulroy/ts-error-translator.nvim",
  config = function()
    require("ts-error-translator").setup({
      auto_attach = true,
      servers = {
        "vtsls",
      },
    })
  end,
}
