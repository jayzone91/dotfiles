local _defaults = {} ---@type table<string, boolean>

local function set_default(option, value)
  local l = vim.api.nvim_get_option_value(option, { scope = "local" })
  local g = vim.api.nvim_get_option_value(option, { scope = "global" })

  _defaults[("%s=%s"):format(option, value)] = true
  local key = ("%s=%s"):format(option, l)

  local source = ""
  if l ~= g and not _defaults[key] then
    -- Option does not match global and is not a default value
    -- Check if it was set by a script in $VIMRUNTIME
    local info = vim.api.nvim_get_option_info2(option, { scope = "local" })
    ---@param e vim.fn.getscriptinfo.ret
    local scriptinfo = vim.tbl_filter(function(e)
      return e.sid == info.last_set_sid
    end, vim.fn.getscriptinfo())
    source = scriptinfo[1] and scriptinfo[1].name or ""
    local by_rtp = #scriptinfo == 1 and vim.startswith(scriptinfo[1].name, vim.fn.expand("$VIMRUNTIME"))
    if not by_rtp then
      return false
    end
  end

  vim.api.nvim_set_option_value(option, value, { scope = "local" })
  return true
end

local M = {}

M._installed = nil ---@type table<string,boolean>
M._queries = nil ---@type table<string,boolean>

---@param update boolean?
function M.get_installed(update)
  if update then
    M._installed, M._queries = {}, {}
    for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
      M._installed[lang] = true
    end
  end
  return M._installed or {}
end

---@param lang string
---@param query string
function M.have_query(lang, query)
  local key = lang .. ":" .. query
  if M._queries[key] == nil then
    M._queries[key] = vim.treesitter.query.get(lang, query) ~= nil
  end
  return M._queries[key]
end

---@param what string|number|nil
---@param query? string
---@overload fun(buf?:number):boolean
---@overload fun(ft:string):boolean
---@return boolean
function M.have(what, query)
  what = what or vim.api.nvim_get_current_buf()
  what = type(what) == "number" and vim.bo[what].filetype or what --[[@as string]]
  local lang = vim.treesitter.language.get_lang(what)
  if lang == nil or M.get_installed()[lang] == nil then
    return false
  end
  if query and not M.have_query(lang, query) then
    return false
  end
  return true
end

function M.foldexpr()
  return M.have(nil, "folds") and vim.treesitter.foldexpr() or "0"
end

function M.indentexpr()
  return M.have(nil, "indents") and require("nvim-treesitter").indentexpr() or -1
end

---@return string?
local function win_find_cl()
  local path = "C:/Program Files (x86)/Microsoft Visual Studio"
  local pattern = "*/*/VC/Tools/MSVC/*/bin/Hostx64/x64/cl.exe"
  return vim.fn.globpath(path, pattern, true, true)[1]
end

function M.check()
  local is_win = vim.fn.has("win32") == 1
  local function have(tool, win)
    return (win == nil or is_win == win) and vim.fn.executable(tool) == 1
  end

  local have_cc = vim.env.CC ~= nil or have("cc", false) or have("ci", true) or (is_win and win_find_cl() ~= nil)

  if not have_cc and is_win and vim.fn.executable("gcc") == 1 then
    vim.env.CC = "gcc"
    have_cc = true
  end

  local ret = {
    ["tree-sitter (CLI)"] = have("tree-sitter"),
    ["C compiler"] = have_cc,
    tar = have("tar"),
    curl = have("curl"),
  }
  local ok = true
  for _, v in pairs(ret) do
    ok = ok and v
  end
  return ok, ret
end

---@param cb fun()
function M.build(cb)
  M.ensure_treesitter_cli(function(_, err)
    local ok, health = M.check()
    if ok then
      return cb()
    else
      local lines = { "Unmet requirements for **nvim-treeesitter** `main`:" }
      local keys = vim.tbl_keys(health) ---@type string[]
      table.sort(keys)
      for _, k in pairs(keys) do
        lines[#lines + 1] = ("- %s `%s`"):format(health[k] and "✅" or "❌", k)
      end
      vim.list_extend(lines, {
        "",
        "See the requirements at [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements)",
        "Run `:checkhealth nvim-treesitter` for more information.",
      })
      if vim.fn.has("win32") == 1 and not health["C compiler"] then
        lines[#lines + 1] =
        "Install a C compiler with `winget install --id=BrechtSanders.WinLibs.POSIX.UCRT -e`"
      end
      vim.list_extend(lines, err and { "", err } or {})
      vim.notify(table.concat(lines, ","), vim.log.levels.ERROR)
    end
  end)
end

---@param cb fun(ok:boolean, err?:string)
function M.ensure_treesitter_cli(cb)
  if vim.fn.executable("tree-sitter") == 1 then
    return cb(true)
  end

  if not pcall(require, "mason") then
    return cb(false, "`mason.nvim` is disabled in your config, so we cannot install it automatically.")
  end

  if vim.fn.executable("tree-sitter") == 1 then
    return cb(true)
  end

  local mr = require("mason-registry")
  mr.refresh(function()
    local p = mr.get_package("tree-sitter-cli")
    if not p:is_installed() then
      vim.notify("Installing `tree-sitter-cli` with `mason.nvim`...", vim.log.levels.INFO)
      p:install(
        nil,
        vim.schedule_wrap(function(success)
          if success then
            vim.notify("Installed `tree-sitter-cli` with `mason.nvim`.", vim.log.levels.INFO)
            cb(true)
          else
            cb(false, "Failed to install `tree-sitter-cli` with `mason.nvim`.")
          end
        end)
      )
    end
  end)
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
  version = false,
  build = function()
    local TS = require("nvim-treesitter")
    if not TS.get_installed then
      vim.notify(
        "Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.",
        vim.log.levels.ERROR
      )
      return
    end

    -- make sure we're using the latest treesitter util
    package.loaded["lazyvim.util.treesitter"] = nil
    M.build(function()
      TS.update(nil, { summary = true })
    end)
  end,
  event = { "VeryLazy" },
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts_extend = { "ensure_installed" },
  opts = {
    indent = { enable = true },
    highlight = { enable = true },
    folds = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typesript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
  },
  config = function(_, opts)
    local TS = require("nvim-treesitter")

    setmetatable(require("nvim-treesitter.install"), {
      __newindex = function(_, k)
        vim.schedule(function()
          vim.notify(
            "Setting custom compilers for `nvim-treesitter` is no longer supported.",
            vim.log.levels.ERROR
          )
        end)
      end,
    })

    if not TS.get_installed then
      return vim.notify("Please use `:Lazy` and update `nvim-treesitter`", vim.log.levels.ERROR)
    elseif type(opts.ensure_installed) ~= "table" then
      return vim.notify("`nvim-treesitter` opts.ensure_installed must be a table", vim.log.levels.ERROR)
    end

    TS.setup(opts)
    M.get_installed(true)

    local install = vim.tbl_filter(function(lang)
      return not M.have(lang)
    end, opts.ensure_installed or {})

    if #install > 0 then
      M.build(function()
        TS.install(install, { summary = true }):await(function()
          M.get_installed(true)
        end)
      end)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
      callback = function(ev)
        local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
        if not M.have(ft) then
          return
        end

        ---@param feat string
        ---@param query string
        local function enabled(feat, query)
          local f = opts[feat] or {}
          return f.enable ~= false
              and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
              and M.have(ft, query)
        end

        -- highlighting
        if enabled("highlight", "highlights") then
          pcall(vim.treesitter.start, ev.buf)
        end

        -- indents
        if enabled("indent", "indents") then
          set_default("indentexpr", "v:lua.LazyVim.treesitter.indentexpr()")
        end

        -- folds
        if enabled("folds", "folds") then
          if set_default("foldmethod", "expr") then
            set_default("foldexpr", "v:lua.LazyVim.treesitter.foldexpr()")
          end
        end
      end,
    })
  end,
}
