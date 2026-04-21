return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "nvim-mini/mini.icons",
    {
      "xzbdmw/colorful-menu.nvim",
      opts = {},
    },
  },
  event = { "InsertEnter", "CmdlineEnter" },
  version = "*",
  ---@module "blink.cmp"
  ---type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    signature = { enabled = true },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function()
            return vim.fn.getcmdtype() == ":"
          end,
        },
        ghost_text = { enabled = true },
      },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      accept = { auto_brackets = { enabled = true } },
      ghost_text = { enabled = false },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        draw = {
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            kind_icon = {
              text = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local mini_icon, _ = require("mini.icons").get(ctx.item.data.type, ctx.label)
                  if mini_icon then
                    return mini_icon .. ctx.icon_gap
                  end
                end

                local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local mini_icon, mini_hl = require("mini.icons").get(ctx.item_data.type, ctx.label)
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
                  local mini_icon, mini_hl = require("mini.icons").get(ctx.item.data.type, ctx.label)
                  if mini_icon then
                    return mini_hl
                  end
                end
                return ctx.kind_hl
              end,
            },
          },
        },
      },
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        spell = {
          name = "Spell",
          module = "blink-cmp-spell",
          opts = {
            enabled_in_context = function()
              local cursor = vim.api.nvim_win_get_cursor(0)
              local captures = vim.treesitter.get_captures_at_pos(0, cursor[1] - 1, cursor[2] - 1)
              local in_spell_capture = false

              for _, cap in ipairs(captures) do
                if cap.capture == "spell" then
                  in_spell_capture = true
                elseif cap.capture == "nospell" then
                  return false
                end
              end
              return in_spell_capture
            end,
          },
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
