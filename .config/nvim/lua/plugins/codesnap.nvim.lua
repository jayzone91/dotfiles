-- TODO: Aktuell ist das Plugin in der Beta und lässt sich unter Windows nicht korrekt starten.
-- Mal auf neuen Updates warten und dann noch mal schauen.

return {
  "mistricky/codesnap.nvim",
  enabled = false,
  tag = "v2.0.0-beta.17",
  config = function()
    local codesnap = require("codesnap")
    codesnap.setup({})

    vim.keymap.set({ "v", "x" }, "<leader>sc", function()
      codesnap.copy()
    end, { desc = "Take a Screenshot (Clipboard)" })

    vim.keymap.set({ "v", "x" }, "<leader>sa", function()
      codesnap.copy_ascii()
    end, { desc = "Take a Screenshot (ASCII Clipboard)" })
  end,
}
