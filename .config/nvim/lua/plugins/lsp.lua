local ok, mason = pcall(require, "mason")
if not ok then
  return
end

mason.setup()

local ok_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if not ok_lsp then
  return
end

mason_lsp.setup()

local ok_tool, mason_tool = pcall(require, "mason-tool-installer")
if not ok_tool then
  return
end

local ensure_installed = {}
local lsp = {
  "lua_ls",
  "astro",
  "gopls",
  "jsonls",
  "marksman",
  "prismals",
  "tailwindcss",
  "vtsls",
  "yamlls",
  "eslint",
}

local formatter = {
  "stylua",
  "prettier",
  "goimports",
  "gofumpt",
}

local linter = {
  "eslint",
  "golangci-lint",
}

table.insert(ensure_installed, lsp)
table.insert(ensure_installed, formatter)
table.insert(ensure_installed, linter)

mason_tool.setup({
  ensure_installed = ensure_installed,
  auto_update = true,
})

local ok_fidget, fidget = pcall(require, "fidget")
if ok_fidget then
  fidget.setup({})
end

local ok_conform, conform = pcall(require, "conform")
if ok_conform then
  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      ["javascript.jsx"] = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      ["typescript.tsx"] = { "prettier" },
      html = { "prettier" },
      astro = { "prettier" },
      go = { "goimports", "gofumpt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  })
end

local ok_lazydev, lazydev = pcall(require, "lazydev.nvim")
if ok_lazydev then
  lazydev.setup({
    library = {
      { path = "${3rd}/luv/library", word = { "vim%.uv" } },
    },
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local blink_ok, blink = pcall(require, "blink.cmp")
if blink_ok then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

local lsp_lines_ok, lsp_lines = pcall(require, "lsp_lines")
if lsp_lines_ok then
  lsp_lines.setup()
  vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false,
  })
end

local lint_ok, lint = pcall(require, "lint")
if lint_ok then
  lint.linters_by_ft = {
    javascript = { "eslint" },
    javascriptreact = { "eslint" },
    ["javascript.jsx"] = { "eslint" },
    typescript = { "eslint" },
    typescriptreact = { "eslint" },
    ["typescript.tsx"] = { "eslint" },
    html = { "eslint" },
    go = { "golangcilint" },
  }

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      lint.try_lint()
    end,
  })
end

for _, server in pairs(lsp) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end

-- LSP Config
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        verion = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

vim.lsp.config("gopls", {
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
})

vim.lsp.config("tailwindcss", {
  -- exclude a filetype from the default_config
  filetypes_exclude = { "markdown" },
  -- add additional filetypes to the default_config
  filetypes_include = {},
  -- to fully override the default_config, change the below
  -- filetypes = {}

  -- additional settings for the server, e.g:
  -- tailwindCSS = { includeLanguages = { someLang = "html" } }
  -- can be addeded to the settings table and will be merged with
  -- this defaults for Phoenix projects
  settings = {
    tailwindCSS = {
      includeLanguages = {
        elixir = "html-eex",
        eelixir = "html-eex",
        heex = "html-eex",
      },
    },
  },
})

vim.lsp.config("vtsls", {
  -- explicitly add default filetypes, so that we can extend
  -- them in related extras
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
})

vim.lsp.config("eslint", {
  settings = {
    -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
    workingDirectories = { mode = "auto" },
  },
})
