return {
  "neovim/nvim-lspconfig",
  event = { "BufEnter" },
  dependencies = {
    "williamboman/mason.nvim",
    "folke/lazydev.nvim",
    { "NvChad/nvim-colorizer.lua", event = "BufReadPre", opts = {} },
  },
  opts = {},
  config = function(_, opts)
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local has_blink, blink = pcall(require, "blink.cmp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      has_blink and blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    local lspconfig = require("lspconfig")

    local servers = require("config.lsp")
    for server, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)
      lspconfig[server].setup(config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = assert(
          vim.lsp.get_client_by_id(args.data.client_id),
          "must have valid client id"
        )

        local settings = servers[client.name]
        if type(settings) ~= "table" then
          settings = {}
        end

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = 0 }
        )
        vim.keymap.set("n", "gd", function()
          Snacks.picker.lsp_definitions()
        end, { desc = "Goto Definition" })
        vim.keymap.set("n", "gr", function()
          Snacks.picker.lsp_references()
        end, { desc = "References" })
        vim.keymap.set("n", "gI", function()
          Snacks.picker.lsp_implementations()
        end, { desc = "Implementations" })
        vim.keymap.set("n", "gT", function()
          Snacks.picker.lsp_type_definitions()
        end, { desc = "Definitions" })
      end,
    })
  end,
}
