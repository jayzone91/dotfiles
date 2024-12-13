return {
  "neovim/nvim-lspconfig",
  event = { "BufEnter", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
    { "Bilal2453/luvit-meta", lazy = true },
  },
  config = function()
    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    local lspconfig = require("lspconfig")

    local servers = require("config.server").lsp

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

        local builtin = require("telescope.builtin")

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = 0 }
        )
      end,
    })
  end,
}
