return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodium = require("neocodeium")
    local cmp = require("cmp")
    local commands = require("neocodeium.commands")

    cmp.event:on("menu_opened", function()
      neocodium.clear()
    end)

    neocodium.setup({
      filter = function(bufnr)
        if vim.endswith(vim.api.nvim_buf_get_name(bufnr), ".env") then
          return false
        end
        return not cmp.visible()
      end,
      filetypes = {
        TelescopePrompt = false,
      },
    })
    vim.keymap.set("i", "<C-d>", neocodium.accept)
  end,
}
