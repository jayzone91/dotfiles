---@type table<string, table<vim.lsp.Client, table<number, boolean>>>
local _supports_method = {}

local function on_supports_method(method, fn)
  _supports_method[method] = _supports_method[method]
    or setmetatable({}, { __mode = "k" })
  return vim.api.nvim_create_autocmd("User", {
    pattern = "LspSupportsMethod",
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer ---@type number
      if client and method == args.data.method then
        return fn(client, buffer)
      end
    end,
  })
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { "nvim-dap-ui" },
      },
    },
  },
  opts = function()
    local ret = {
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      },
      inlay_hints = {
        enabled = true,
        exlude = { "vue" },
      },
      codelens = { enabled = true },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
    }
    return ret
  end,
  config = function(_, opts)
    local servers = require("config.lsp")
    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    for server, config in pairs(servers) do
      if type(config) ~= "table" then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)
      require("lspconfig")[server].setup(config)
    end

    if vim.fn.has("nvim-0.10.0") == 0 then
      if type(opts.diagnostics.signs) ~= "boolean" then
        for severity, icon in pairs(opts.diagnostics.signs.text) do
          local name =
            vim.diagnostics.severity[severity]:lower():gsub("^%1", string.upper)
          name = "DiagnosticSign" .. name
          vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
        end
      end
    end

    if vim.fn.has("nvim-0.10") == 1 then
      if opts.inlay_hints.enabled then
        on_supports_method("textDocument/inlayHint", function(client, buffer)
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ""
            and not vim.tbl_contains(
              opts.inlay_hints.exclude,
              vim.bo[buffer].filetype
            )
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      if opts.codelens.enabled and vim.lsp.codelens then
        on_supports_method("textDocument/codeLens", function(client, buffer)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd(
            { "BufEnter", "CursorHold", "InsertLeave" },
            {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            }
          )
        end)
      end
    end
    local icons = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    }

    if
      type(opts.diagnostics.virtual_text) == "table"
      and opts.diagnostics.virtual_text.prefix == "icons"
    then
      opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0
          and "●"
        or function(diagnostic)
          local icons = icons
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
  end,
}
