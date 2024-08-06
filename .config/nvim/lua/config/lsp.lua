local servers = require("config.mason.lsp-server")
require("config.mason")
require("mason-lspconfig").setup()

local max_items = 5

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")
local lspkind = require("lspkind")

require("lspconfig.ui.windows").default_options.border = "rounded"

vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = true,
  virtual_text = {
    source = "if_many",
    prefix = "●",
  },
})

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

for lsp, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {}, {
    capabilities = capabilities,
  }, config)
  lspconfig[lsp].setup(config)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(
      vim.lsp.get_client_by_id(args.data.client_id),
      "must have valid client"
    )

    local builtin = require("telescope.builtin")

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
    vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
  end,
})

-- Snippets
local luasnip = require("luasnip")

-- cmp setup
local cmp = require("cmp")
cmp.setup({
  window = {
    completion = {
      border = {
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "󱐋", "WarningMsg" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "─", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "╮", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "│", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "╯", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "─", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "╰", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "│", "Comment" },
      },
      scrollbar = false,
    },
    documentation = {
      border = {
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "", "DiagnosticHint" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "─", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "╮", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "│", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "╯", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "─", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "╰", "Comment" },
        ---@diagnostic disable-next-line:assign-type-mismatch
        { "│", "Comment" },
      },
      scrollbar = false,
    },
  },
  completion = {
    completeopt = "menu,menuone,preview,noinsert",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp", max_item_count = max_items },
    { name = "luasnip", max_item_count = max_items },
    { name = "buffer", max_item_count = max_items },
    { name = "path", max_item_count = max_items },
    { name = "lazydev", max_item_count = max_items, group_index = 0 },
  }),
  -- configure lspkind for vs-code like pictograms in completion menu
  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer", max_item_count = max_items },
  },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path", max_item_count = max_items },
  }, {
    { name = "cmdline", max_item_count = max_items },
  }),
})

require("lsp_lines").setup()
vim.diagnostic.config({ virtual_text = false })
