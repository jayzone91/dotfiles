local icons = {
  kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = "󱄽 ",
    String = " ",
    Struct = "󰆼 ",
    Supermaven = " ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
  },
}

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      -- snippet plugin
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      config = function(_, opts)
        require("luasnip").config.set_config(opts)
        -- vscode format
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({
          paths = vim.g.vscode_snippets_path or "",
        })

        -- snipmate format
        require("luasnip.loaders.from_snipmate").load()
        require("luasnip.loaders.from_snipmate").lazy_load({
          paths = vim.g.snipmate_snippets_path or "",
        })

        -- lua format
        require("luasnip.loaders.from_lua").load()
        require("luasnip.loaders.from_lua").lazy_load({
          paths = vim.g.lua_snippets_path or "",
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
          callback = function()
            if
              require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
              and not require("luasnip").session.jump_active
            then
              require("luasnip").unlink_current()
            end
          end,
        })
      end,
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  opts = function()
    local cmp = require("cmp")

    local cmp_ui = {
      icons = true,
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
      selected_item_bg = "simple", -- colored / simple
    }
    local cmp_style = cmp_ui.style

    local function border(hl_name)
      return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
    end

    local formatting = {
      format = function(_, item)
        if icons.kinds[item.kind] then
          item.kind = icons.kinds[item.kind] .. item.kind
        end

        local widths = {
          abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
          menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
        }

        for key, width in pairs(widths) do
          if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
            item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
          end
        end

        return item
      end,
    }

    local options = {
      completion = {
        completeopt = "menu,menuone",
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      formatting = formatting,
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(
              vim.api.nvim_replace_termcodes(
                "<Plug>luasnip-expand-or-jump",
                true,
                true,
                true
              ),
              ""
            )
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(
              vim.api.nvim_replace_termcodes(
                "<Plug>luasnip-jump-prev",
                true,
                true,
                true
              ),
              ""
            )
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
        { name = "nvim_lua" },
      },
    }

    if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
      options.window.completion.border = border("CmpBorder")
    end

    return options
  end,
  config = function(_, opts)
    require("cmp").setup(opts)
  end,
}
