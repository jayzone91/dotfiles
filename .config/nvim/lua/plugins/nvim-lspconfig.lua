return {
  "neovim/nvim-lspconfig",
  event = { "BufEnter", "BufNewFile" },
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
  },
  opts = {
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
  },
  config = function(_, opts)
    local lsp_server = require("config.lsp")
    local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
    local has_blink, blink = pcall(require, "blink.cmp")

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp.default_capabilities() or {},
      has_blink and blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    for server, config in pairs(lsp_server) do
      if type(config) ~= "table" then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)

      vim.lsp.enable(server)
      vim.lsp.config(server, config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
      end,
    })

    require("lsp_lines").setup()
    vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
  end,
}
