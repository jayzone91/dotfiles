return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    { "nvim-mini/mini.icons", version = false, opts = {} },
  },
  version = "1.*",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "enter" },
    appearance = { nerd_font_variant = "mono" },
    signature = { enabled = true },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function(_)
            return vim.fn.getcmdtype() == ":"
          end,
        },
        ghost_text = { enabled = true },
      },
    },
    fuzzy = {
      sorts = {
        "exact",
        "score",
        "sort_text",
        "label",
      },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      accept = { auto_brackets = { enabled = true } },
      ghost_text = { enabled = false },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              text = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local mini_icon, _ = require("mini.icons").get_icon(
                    ctx.item.data.type,
                    ctx.label
                  )
                  if mini_icon then
                    return mini_icon .. ctx.icon_gap
                  end
                end
                local icon =
                  require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local mini_icon, mini_hl = require("mini.icons").get_icon(
                    ctx.item.data.type,
                    ctx.label
                  )
                  if mini_icon then
                    return mini_hl
                  end
                end
                return ctx.kind_hl
              end,
            },
            kind = {
              highlight = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local mini_icon, mini_hl = require("mini.icons").get_icon(
                    ctx.item.data.type,
                    ctx.label
                  )
                  if mini_icon then
                    return mini_hl
                  end
                  return ctx.kind_hl
                end
              end,
            },
          },
        },
      },
    },
    sources = {
      default = function()
        local sources = { "lazydev", "lsp", "path", "snippets", "buffer" }

        local ok, node = pcall(vim.treesitter.get_node)

        if ok and node then
          if
            not vim.tbl_contains(
              { "comment", "line_comment", "block_comment" },
              node:type()
            )
          then
            table.insert(sources, "path")
          end
          if node:type() ~= "string" then
            table.insert(sources, "snippets")
          end
        end

        return sources
      end,
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
