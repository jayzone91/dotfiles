local lsp_server = require("installs.lsp")

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
          { path = "nvim-lspconfig", words = { "lspconfig.settings" } },
        },
      },
    },
    {
      "mason-org/mason.nvim",
    },
    { "mason-org/mason-lspconfig.nvim", opts = {} },
  },
  config = function()
    -- Get Capabilites
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if pcall(require, "cmp_nvim_lsp") then
      vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    end

    if pcall(require, "blink.cmp") then
      vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
    end

    -- Set Hover
    local on_attach = function() end
    --
    -- Config LSP Servers
    for server, config in pairs(lsp_server) do
      config = config or {}

      vim.tbl_extend("force", { capabilities = capabilities, on_attach = on_attach }, config)

      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Actions")
        map("gD", vim.lsp.buf.declaration, "Declaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight", event.buf) then
          local highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        if client and client:supports_method("textDocument/inlayHint", event.buf) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ buffer = event.buf }))
          end, "Toggle Inlay Hints")
        end
      end,
    })
  end,
}
